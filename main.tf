terraform {

    backend "http" {
    address        = "https://api.tfstate.dev/github/v1"
    lock_address   = "https://api.tfstate.dev/github/v1/lock"
    unlock_address = "https://api.tfstate.dev/github/v1/lock"
    lock_method    = "PUT"
    unlock_method  = "DELETE"
    username       = "wdewww/TP_IAC"
  }
    
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

variable "db_user" {
    description = "user name of the database"
    type = string
    default = "admin"
}
variable "db_password" {
    description = "password of db user"
    type = string
    default = "admin"
}
variable "db_name" {
    description = "name of database"
    type = string
    default = "test"
}

resource "docker_image" "db" {
  name         = "postgres:latest"
  keep_locally = false
}

resource "docker_container" "db" {
  image = docker_image.db.image_id
  name  = "db"
  ports {
    external = 5432
    internal = 5432
  }
  env =  [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
}


resource "docker_image" "app" {
    name = "app"
    build {
        context = "."
    labels  = {
        author = "zouari-elbour-youssef"
    }
    }
}

resource "docker_container" "app" {
    image = docker_image.app.image_id
    name = "app"
    ports {
        internal = 80
        external = 8080
    }
}
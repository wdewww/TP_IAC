output "app_container_id" {
    description = "ID of the docker container of my app"
    value = docker_container.app.id
}

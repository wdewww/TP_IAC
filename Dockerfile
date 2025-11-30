FROM nginx:1.29.3-alpine-slim

RUN echo "<h1>Application Deployed via Terraform IaC!</h1>" > /usr/share/nginx/html/index.html
EXPOSE 80

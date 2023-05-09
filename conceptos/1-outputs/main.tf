

resource "docker_container" "contenedor" {
    name        = "minginx"
    image       = docker_image.imagen.image_id 
}

resource "docker_image" "imagen" {
    name = "nginx:latest"
}

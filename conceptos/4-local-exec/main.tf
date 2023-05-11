terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.25.0"
        }
    }
}

provider "docker" {
}

resource "docker_container" "contenedor" {
    name        = "minginx"
    image       = docker_image.imagen.image_id
    
    # Quiero probar que el nginx queda funcionando
    provisioner "local-exec" {
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "ping -c 1 ${self.network_data[0].ip_address}6"
        # En este caso, el comando falla.. Y devuelve un codigo de respuesta distinto de CERO
        on_failure = continue # Con esto fuerzo a que, aunque la prueba falle, el script continue
    }
    provisioner "local-exec" {
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "curl -s ${self.network_data[0].ip_address}"
    }
    
}

resource "docker_image" "imagen" {
    name = "nginx:latest"
}

resource "docker_container" "contenedor" {
    name        = var.nombre_contenedor  # "minginx"
    image       = docker_image.imagen.image_id 
    
    # Esto ya no funcionalidad
    #env         = var.variables_de_entorno
    # Pues ya os imaginais.. A convertir el tipo de dato se ha dicho !
    
    must_run    = var.autoarrancar_el_contenedor
    ports       {
                    internal = 80
                    external = 8080
    }
    ports       {
                    internal = 443
                    external = 8443
    }
}

resource "docker_image" "imagen" {
           # Interpolacion de textos
    name = "${var.imagen_repo}:${var.imagen_tag}"
              # Aqui dentro puedo poner cualquier expresión
}

resource "docker_container" "contenedor" {
    name        = var.nombre_contenedor  # "minginx"
    image       = docker_image.imagen.image_id 
    
    # Esto ya no funcionalidad
    #env         = var.variables_de_entorno
    # Pues ya os imaginais.. A convertir el tipo de dato se ha dicho !
    
    env         = [ for clave, valor in var.variables_de_entorno : "${clave}=${valor}" ]
    # Asignar a una propiedad de un recurso el valor null
    # Es lo mismo que no haber escrito esa linea.
    # No le mandamos al proveedor información de la propiedad
    # cpu_shares  = null #var.cuota_cpu
    cpu_shares  = var.cuota_cpu
    must_run    = var.autoarrancar_el_contenedor
    
    dynamic "ports" {
        for_each    =   var.puertos_del_contenedor  # Necesito aqui pasar una LISTA o SET
        iterator    =   puerto # Nombre con que me voy a referir a cada elemento de la lista
        content {
                    internal = puerto.value.interno
                    external = puerto.value.externo
                    protocol = puerto.value.protocolo
                    ip       = puerto.value.ip
        }
    }
}

resource "docker_image" "imagen" {
           # Interpolacion de textos
    name = "${var.imagen_repo}:${var.imagen_tag}"
              # Aqui dentro puedo poner cualquier expresión
}


resource "docker_image" "imagen" {
    name = "nginx:latest"
}

# La variable "docker_container.contenedor" que
# devolvía en scripts anteriores? una referencia a UN RECURSO
#
# Pero ahora, al usar "count" que devuelve?
# Una lista con referencias a CADA RECURSO CREADO
resource "docker_container" "contenedor" {
    count       =  var.numero_de_contenedores # Aqui pasamos un número
    # Por el hecho de usar count.. tenemos a nuestra disposición
    # la variable "count.index", que me dice por cual voy
    name        = "minginx-${count.index}"
    image       = docker_image.imagen.image_id 
    ports       {
                    internal    =   80
                    external    =   8080 + count.index
    }
}

resource "docker_container" "contenedor_personalizado" {
    # count       =  length( var.contenedores_a_crear_con_sus_puertos )   UPS !
    for_each    =  var.contenedores_a_crear_con_sus_puertos
                    # Aqui SOLO PODEMOS PASAR:
                        # Una lista si es de strings = KK No vale pa' na'
                        # O un mapa! <<<< Esto nos interesa
                    # MIERDA !!!! Este for_each NO SE PARECE AL FOR_EACH del DYNAMIC
    # Por el hecho de usar for_each.. tenemos a nuestra disposición
    # la variable "each", a la que le puedo pedir: each.key, each.value
    name        = each.key
    image       = docker_image.imagen.image_id 
    ports       {
                    internal    =   80
                    external    =   each.value
    }
}

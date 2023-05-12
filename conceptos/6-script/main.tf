module "contenedor" {
    source                      = "../5-modulo"
                                # Los módulos los podemos tene ubicados en muchos sitios:
                                # https://developer.hashicorp.com/terraform/language/modules/sources
    nombre_contenedor           = "contenedor"
    imagen_repo                 = "nginx"
    puertos_del_contenedor      = [            
                                     {
                                         interno = 80
                                         externo = 8080
                                     }
                                   ]
}
module "contenedor1" {
    source                      = "../5-modulo"
    nombre_contenedor           = "contenedor1"
    imagen_repo                 = "nginx"
}
module "contenedor2" {
    source                      = "../5-modulo"
    nombre_contenedor           = "contenedor2"
    imagen_repo                 = "nginx"
    puertos_del_contenedor      = [            
                                     {
                                         interno = 80
                                         externo = 8081
                                     }
                                   ]

}
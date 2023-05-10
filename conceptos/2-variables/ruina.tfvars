
nombre_contenedor           = "r2-d2PQ&&$··)()' Felipón"
imagen_repo                 = "nginx"
imagen_tag                  = "latest"
autoarrancar_el_contenedor  = true
variables_de_entorno        = {
                                VARIABLE1 = "VALOR1"
                                VARIABLE2 = "VALOR2"
                              }
cuota_cpu                   = -20000
puertos_del_contenedor      = [                                                 # Este esta genial !!!!
                                 {
                                     interno = 800000
                                     externo = 8080
                                 },
                                 {
                                     interno = 443
                                     externo = 8443
                                     ip      = "manzana"
                                     protocolo = "federico"
                                 }
                               ]

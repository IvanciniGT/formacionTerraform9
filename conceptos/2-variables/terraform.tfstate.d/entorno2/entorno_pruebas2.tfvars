nombre_contenedor = "minginx2"
puertos_del_contenedor      = [                                                 # Este esta genial !!!!
                                 {
                                     interno = 80
                                     externo = 8081
                                 },
                                 {
                                     interno = 443
                                     externo = 8441
                                     ip      = "0.0.0.0"
                                     protocolo = "tcp"
                                 }
                               ]

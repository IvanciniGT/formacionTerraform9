numero_de_contenedores  = 2

contenedores_a_crear_con_sus_puertos = {
                                            contenedorA = 8085
                                            contenedorB = 9095
                                        }

# Aquí hay una ventaja 
# Los nombres de contenedor se tratan como IDENTIFICADORES UNICOS !
contenedores_a_crear_mas_personalizados = {
                                            contenedorA1 = {
                                                                puerto = 10000
                                                                ip     = "127.0.0.1"
                                                          }
                                            contenedorB1 = {
                                                                puerto = 11000
                                                          }
                                          }                                

# Mas natural: Lista de contenedores
# Es más explicita
contenedores_a_crear_mas_personalizados2 = [
                                                {
                                                    nombre = "contenedorA2"
                                                    puerto = 10001
                                                    ip     = "127.0.0.1"
                                                },
                                                {
                                                    nombre = "contenedorB2"
                                                    puerto = 11001
                                                }
                                           ]
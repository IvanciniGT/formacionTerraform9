# Que defino en este fichero? 
# Los valores por defecto de las variables para mi script!

nombre_contenedor           = "nombre_por_defecto-1"
imagen_repo                 = "nginx"
imagen_tag                  = "latest"
autoarrancar_el_contenedor  = true
variables_de_entorno        = {
                                VARIABLE1 = "VALOR1"
                                VARIABLE2 = "VALOR2"
                              }
cuota_cpu                   = null
puertos_del_contenedor      = [                                                 # Este esta genial !!!!
                                 {
                                     interno = 80
                                     externo = 8080
                                 },
                                 {
                                     interno = 443
                                     externo = 8443
                                     ip      = "0.0.0.0"
                                     protocolo = "tcp"
                                 }
                               ]
#                                    vvvvvv
#                              [
#                                "VARIABLE1=VALOR1",
#                                "VARIABLE2=VALOR2"
#                              ]

# 2 Listas                                                                      NO NOS GUSTA. Por qué?
# puertos_internos_del_contenedor = [80,443]                                      # Si solo tenemos 2 cuela... si tenemos más vamos jodidos
# puertos_externos_del_contenedor = [8080,8443]                                   # Comportamiento mágico! No es explicito! 
                                                                                # Problema de mnto
# 1 Lista                                                                       Tampoco... por lo mismo.. De hecho es peor
# puertos_del_contenedor_apinados = [80, 8080, 443, 8443]
# 1 lista por cada par de puertos                                               NOP... Me pasa igual: 2 puertos.. y si quiero 15... Buff !
# puerto_http                     = [80, 8080]
# puerto_https                    = [443, 8443]
# Lista de listas                                                               # Ein!!!!
# puertos_del_contenedor_como_lista = [
#                                         [80, 8080],
#                                         [443, 8443]
#                                     ]
# Mapa de listas                                                                Algo Mejor
# puertos_del_contenedor_como_mapa =  {
#                                         http  = [80, 8080]                        # No queda explicito: Puerto interno / externo
#                                         https = [443, 443]
#                                     }
# puertos_del_contenedor_como_mapa =  {                                           # No va mal
#                                         internos  = [80, 443]                   # Problema: Cada puerto interno no está relaciona con el puerto externo
#                                         externos = [8080, 8443]                 # La relación es debil (por la posición en la lista).
#                                     }                                           # Mnto de esto es una locura como haya muchos
# Mapa de mapas
# puertos_del_contenedor_como_mapas = {                                           # Tiene muy buena pinta
#                                         http = {                                # Pero tiene una cagada !
#                                             interno = 80
#                                             externo = 8080
#                                         },
#                                         https = {
#                                             interno = 443
#                                             externo = 8443
#                                         }
#                                     }
# Lista de diccionarios                                                         Tiene muy buena pinta
# List(Map(number))
# puertos_del_contenedor      = [                                                 # Pero también tiene una cagada
#                                 {
#                                     interno = 80
#                                     externo = 8080
#                                 },
#                                 {
#                                     interno = 443
#                                     federico = 8443
#                                     ip      = "127.0.0.1"
#                                     proto   = "tcp"
#                                 }
#                               ]
# set(object({
#                                interno     = number
#                                externo     = number
#                                ip          = optional(string, "127.0.0.1")
#                                protocolo   = optional(string, "tcp")
#                            }))
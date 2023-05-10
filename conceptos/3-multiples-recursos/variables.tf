variable "numero_de_contenedores" {
    type            = number
    description     = "Número de contenedores a crear"
}
# Que os parece? A mi GUAY !
# Siempre y cuando ... esos contenedores no requieran de mucha personalización

# Y si requiero de más personalización?
# Quiero poder poner nombres arbitrarios y puertos externos arbitrarios a cada contenedor
# contenedorA < 8090
# contenedorB < 9090

variable "contenedores_a_crear_con_sus_puertos" {
    type            = map(number)
    description     = "Contenedores a crear con sus puertos"
}
# Que os parece? A mi GUAY !
# Siempre y cuando ... esos contenedores solo requieran de un dato a personalizar

# Y si quiero personalizar: Puerto externo e IP? 

variable "contenedores_a_crear_mas_personalizados" {
    type            = map(object({
                                        puerto  = number
                                        ip      = string
                                    }))
    description     = "Contenedores a crear con sus puertos e IPs"
}

variable "nombre_contenedor" {
    type = string
    description = "Nombre del contenedor que vamos a crear"
    #default = "minginx" # Esto me permitiría dar un valor por defecto a la variable 
                         # NUNCA JAMAS SE ASIGNA UN VALOR POR DEFECTO A UNA VARIABLE EN UN SCRIPT
                         # MUY MALA PRACTICA !
                         # Venga tio... Y entonces para que sirve esto?
                         # Para esto NO sirve. 
                         # El jueves os cuento para que sirve esa marca default !
}

variable "imagen_repo" {
    type        = string
    description = "Repo del que descargar la imagen a utilizar para crear el contenedor"
}

variable "imagen_tag" {
    type        = string
    description = "Tag de la imagen a utilizar para crear el contenedor"
}

variable "autoarrancar_el_contenedor" {
    type        = bool
    description = "Indica si el contenedor se debe ejcutar al crearse"
}

#variable "variables_de_entorno" {
#    type        = set(string)
#    description = "Variables de entorno para el contenedor"
#} 
# ESTO ES UNA MIERDA GIGANTE !!!
# COMPORTAMIENTO MÁGICO !!!!!!
# Que tengo que poner en esos strings? 
# Donde queda explicitado el formato de los strings? En ningun sitio
# Quien lo comprueba?  NADIE
#
# POR DIOS !!!! SIEMPRE EXPLICITO !!!!!!!!

variable "variables_de_entorno" {
    type        = map(string)
    description = "Variables de entorno para el contenedor"
} 
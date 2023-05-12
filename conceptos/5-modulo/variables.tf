variable "nombre_contenedor" {
    type = string
    description = "Nombre del contenedor que vamos a crear"
    #default = "minginx" # Esto me permitiría dar un valor por defecto a la variable 
                         # NUNCA JAMAS SE ASIGNA UN VALOR POR DEFECTO A UNA VARIABLE EN UN SCRIPT
                         # MUY MALA PRACTICA !
                         # Venga tio... Y entonces para que sirve esto?
                         # Para esto NO sirve. 
                         # Para definir los davors por defecto en los MODULOS
    validation {
        # Expresiones regulares... sencillo ! Siempre y cuando sepa de regex
        // PATRON: "^[a-zA-Z][a-zA-Z0-9_-]{4,}$"
        condition   = length( regexall("^[a-zA-Z][a-zA-Z0-9_-]{4,}$", var.nombre_contenedor) ) == 1
        error_message = "El nombre del conteendor debe empezar por una letra, y tener al menos otros 4 caracteres, donde adicionalemnte se pueden usar dígitos, guiones medios y bajos"
    }
}

variable "imagen_repo" {
    type        = string
    description = "Repo del que descargar la imagen a utilizar para crear el contenedor"
}

variable "imagen_tag" {
    type        = string
    description = "Tag de la imagen a utilizar para crear el contenedor"
    default     = "latest"
}

variable "autoarrancar_el_contenedor" {
    type        = bool
    description = "Indica si el contenedor se debe ejcutar al crearse"
    default     = true
}

variable "cuota_cpu" {
    type        = number
    description = "Indica la cuota de cpu permitida para el contenedor (base 1024 = 1 core)"
    # Concepto RARO donde lo haya
    nullable    = true
    default     = null
    # El valor null es un valor ADICIONAL en terraform, que debe ser ASIGNADO
    # Significa que la variable, ADEMAS de poder contener un valor del tipo suministrado,
    # TAMBIEN PUEDE CONTENER EL VALOR null
    
    # Puedo definir validaciones que TERRAFORM hará a las variables antes de comenzar
    # Puedo definir muchas. Para que el valor se de por bueno, TODAS deben cumplirse
    # En una validación NUNCA PUEDO REFERENCIAR A OTRA VARIABLE. Terraform me da error
    validation {
        condition       =   var.cuota_cpu == null ? true : var.cuota_cpu > 0 # && var.cuota_cpu <= 4096 Esto funciona. No me compensa
                            # OPERADORES PERMITIDOS: + - * / > < == != && ||
                            # Hemos de poner una expresión de que devuelva true o false
                            # Si devuelve true, se entiende que la variable está correctamente rellena
                            # Si devuelve false, TERRAFORM PARA y muestra el "error_message"
        error_message   =   "El valor de la quota de cpu tiene que ser mayor que CERO"
    }
    validation {
        condition       =   var.cuota_cpu == null ? true : var.cuota_cpu <= 4096 
                            # Hemos de poner una expresión de que devuelva true o false
                            # Si devuelve true, se entiende que la variable está correctamente rellena
                            # Si devuelve false, TERRAFORM PARA y muestra el "error_message"
        error_message   =   "El valor de la quota de cpu tiene que ser como mucho 4096"
    }
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
    default     = {}
} 

variable "puertos_del_contenedor" {
    type        = set(object({
                                interno     = number    # En un rango
                                externo     = number    # En un rango
                                ip          = optional(string, "127.0.0.1") # regex
                                protocolo   = optional(string, "tcp")   # tcp upd
                            }))
    description = "Puertos a exponer del contenedor"
    default     = []
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: puerto.interno > 0 ] )
        error_message   = "El puerto interno debe ser mayor que 0"
    }
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: puerto.externo > 0 ] )
        error_message   = "El puerto externo debe ser mayor que 0"
    }
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: puerto.interno < 32500 ] )
        error_message   = "El puerto interno debe ser menor que 32500"
    }
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: puerto.externo < 32500 ] )
        error_message   = "El puerto externo debe ser menor que 32500"
    }
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: 
                                        contains( ["tcp","udp"] , puerto.protocolo) ] )
        error_message   = "El protocolo debe ser tcp o udp"
    }    
    validation {
        condition       = alltrue ( [ for puerto in var.puertos_del_contenedor: 
                                        length( regexall("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$", puerto.ip) ) == 1
                                    ] )
        error_message   = "La IP del puerto debe ser válida"
    }
}
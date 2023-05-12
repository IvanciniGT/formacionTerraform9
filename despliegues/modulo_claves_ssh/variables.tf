variable "directorio_ficheros_claves" {
    description         = "Directorio donde exportar/importar las claves"
    type                = string
    nullable            = false
    default             = "./claves"
    validation {
        condition       = length(regexall("^(((([.]{1,2}[\\/])|[\\/])?([a-zA-Z0-9_-]+[\\/]?))|[.]+)$", var.directorio_ficheros_claves )) == 1
                         # ./claves
                         # ../claves
                         # /claves
                         # claves
                         # ./claves/
                         # ../claves/
                         # /claves/
                         # claves/
        error_message   = "Directorio no válido"
    }
}
variable "regenerar_claves_si_existen" {
    description         = "Indica si deben regenerarse las claves aún existiendo los ficheros en el directorio correspondiente"
    type                = bool
    nullable            = false
    default             = false
}
variable "algoritmo" {
    description         = "Algoritmo a utilizar para la generación de las claves"
    type                = object({
                                    nombre          = string
                                    configuracion   = optional(string) #, null <<<< Eso es por defeccto si no paso valor por defecto
                                                                #any
                                                      # Aunque RSA admite números
                                                      # Terraform autoconvierte el tipo
                                })
    nullable            = false
    default             = {
                            nombre  = "RSA" # "rsa"
                            configuracion = "P256" # "p256"
                          }
    validation {
        condition       = contains( ["RSA", "ECDSA", "ED25519"] , upper(var.algoritmo.nombre) )
        error_message   = "El algoritmo debe de ser uno entre: RSA, ECDSA, ED25519"
    }
    
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "RSA" 
                                ? true
                                : ! can( tonumber(var.algoritmo.configuracion )) 
                                    ? false
                                    : tonumber( var.algoritmo.configuracion ) > 512
                                      && tonumber( var.algoritmo.configuracion ) < 4096
                                      && ceil(tonumber( var.algoritmo.configuracion )) == tonumber( var.algoritmo.configuracion ) # Me aseguro que sea entero
                                
                          )
        error_message   = "Para el algoritmo RSA debe suministrar un número entre 512 y 4096"
    }
    
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "ECDSA" 
                                ? true
                                : contains( ["P224", "P256", "P384", "P521"] , upper(var.algoritmo.configuracion )) )
        error_message   = "Para el algoritmo ECDSA debe suministrar una configuración entre: P224, P256, P384, P521"
    }
    validation {
        condition       = ( upper(var.algoritmo.nombre) != "ED25519" 
                                ? true
                                : var.algoritmo.configuracion == null )
        error_message   = "Para el algoritmo ED25519 no debe suministrar una configuración"
    }
}

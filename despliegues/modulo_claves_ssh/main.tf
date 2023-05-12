locals {

    nombre_algoritmo                        = upper(var.algoritmo.nombre)
    directorio_ficheros_claves_normalizado  = ( endswith( var.directorio_ficheros_claves, "/") 
                                                ? var.directorio_ficheros_claves
                                                : "${var.directorio_ficheros_claves}/" )

    fichero_clave_privada_pem               = "${local.directorio_ficheros_claves_normalizado}clavePrivada.pem"
    fichero_clave_privada_openssh           = "${local.directorio_ficheros_claves_normalizado}clavePrivada.openssh"
    fichero_clave_publica_pem               = "${local.directorio_ficheros_claves_normalizado}clavePublica.pem"
    fichero_clave_publica_openssh           = "${local.directorio_ficheros_claves_normalizado}clavePublica.openssh"

    existe_fichero_clave_privada_pem        = fileexists( local.fichero_clave_privada_pem     ) 
    existe_fichero_clave_privada_openssh    = fileexists( local.fichero_clave_privada_openssh ) 
    existe_fichero_clave_publica_pem        = fileexists( local.fichero_clave_publica_pem     ) 
    existe_fichero_clave_publica_openssh    = fileexists( local.fichero_clave_publica_openssh ) 
    
    existen_ficheros_claves                 = ( local.existe_fichero_clave_privada_pem      &&
                                                local.existe_fichero_clave_privada_openssh  &&
                                                local.existe_fichero_clave_publica_pem      &&
                                                local.existe_fichero_clave_publica_openssh  )
                                                
    se_generan_claves                       = ! local.existen_ficheros_claves || var.regenerar_claves_si_existen
    
    contenido_fichero_clave_privada_pem     = local.existe_fichero_clave_privada_pem     ? file(local.fichero_clave_privada_pem)     : null
    contenido_fichero_clave_privada_openssh = local.existe_fichero_clave_privada_openssh ? file(local.fichero_clave_privada_openssh) : null
    contenido_fichero_clave_publica_pem     = local.existe_fichero_clave_publica_pem     ? file(local.fichero_clave_publica_pem)     : null
    contenido_fichero_clave_publica_openssh = local.existe_fichero_clave_publica_openssh ? file(local.fichero_clave_publica_openssh) : null
}

resource "tls_private_key" "claves" {
    count       = local.se_generan_claves ? 1 : 0
    algorithm   = local.nombre_algoritmo
    ecdsa_curve = local.nombre_algoritmo == "ECDSA" ? upper(var.algoritmo.configuracion) : null
    rsa_bits    = local.nombre_algoritmo == "RSA"   ? var.algoritmo.configuracion        : null
    
    provisioner "local-exec" {
        command = <<EOT
                        mkdir -p ${local.directorio_ficheros_claves_normalizado}
                        echo "${self.private_key_openssh}"  > ${local.fichero_clave_privada_openssh}
                        echo "${self.private_key_pem}"      > ${local.fichero_clave_privada_pem}
                        echo "${self.public_key_openssh}"   > ${local.fichero_clave_publica_openssh}
                        echo "${self.public_key_pem}"       > ${local.fichero_clave_publica_pem}
                    EOT
    }
    
}

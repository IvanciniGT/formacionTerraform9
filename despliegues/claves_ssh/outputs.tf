output "claves" {
    value = (
                local.se_generan_claves 
                    ?   {   # Se rellenan desde un recurso
                            publica = {
                                        openssh = tls_private_key.claves[0].public_key_openssh
                                        pem     = tls_private_key.claves[0].public_key_pem
                                      }
                            privada = {
                                        openssh = tls_private_key.claves[0].private_key_openssh
                                        pem     = tls_private_key.claves[0].private_key_pem
                                      }
                        }
                    :   {   # Se rellenan desde fichero
                            publica = {
                                        openssh = local.contenido_fichero_clave_publica_openssh
                                        pem     = local.contenido_fichero_clave_publica_pem
                                      }
                            privada = {
                                        openssh = local.contenido_fichero_clave_privada_openssh
                                        pem     = local.contenido_fichero_clave_privada_pem
                                      }
                        }
            )
}

# claves.publica.pem
# claves.publica.openssh
# claves.privada.openssh
# claves.privada.pem

terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.25.0"
        }
        null = {
            source = "hashicorp/null"
            version = "3.2.1"
        }
    }
}

provider "null" {
}
provider "docker" {
}

resource "docker_container" "contenedor" {
    name        = "minginx-${count.index}"
    count       = 15
    image       = docker_image.imagen.image_id
    
    # Quiero probar que el nginx queda funcionando
    provisioner "local-exec" {
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "ping -c 1 ${self.network_data[0].ip_address}6"
        # En este caso, el comando falla.. Y devuelve un codigo de respuesta distinto de CERO
        on_failure = continue # Con esto fuerzo a que, aunque la prueba falle, el script continue
    }
    provisioner "local-exec" {
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "curl -s ${self.network_data[0].ip_address}"
    }
    provisioner "local-exec" {
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "echo BORRADO"
        when    = destroy   # Se ejecuta al borrar un recurso
    }
    # Quiero generar un fichero con la IP del contenedor
    # Fichero direcciones.ip.txt
    # NOMBRE_CONTENEDOR=IP
    provisioner "local-exec" { 
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = "echo ${self.name}=${self.network_data[0].ip_address} >> direcciones.ip.txt"
    } # RUINA !
    # Cuando se ejecuta un provisionador?
    # Para cada recurso
    
    
}

resource "docker_image" "imagen" {
    name = "nginx:latest"
}
# Variables internas... o algo asi
locals {
    maquinas_ips =  join("\n", 
                            [ for contenedor in docker_container.contenedor: 
                                    "${contenedor.name}=${contenedor.network_data[0].ip_address}" ]
                    )
                    # Esta expresión se evalua bajo demanda... cada vez que se invoca al local!
    # De hecho, locals no permite definir variables... sino nombres con los que referirinos comodamente a EXPRESIONES
                    
}
resource "null_resource" "regenerar_fichero_ips" {
    triggers = {
        maquinas_y_sus_ips = local.maquinas_ips
    }
    provisioner "local-exec" { 
        #command = "ping -c 1 ${docker_container.contenedor.network_data[0].ip_address}"
        command = <<EOT
                        mkdir -p ips
                        echo "$MAQUINAS_CON_IPS" > ips/maquinas.txt
                    EOT
        
        interpreter = ["/bin/bash" , "-c"] # python, perl ps1
        
        environment = {
            MAQUINAS_CON_IPS = local.maquinas_ips
        }
    } 
}
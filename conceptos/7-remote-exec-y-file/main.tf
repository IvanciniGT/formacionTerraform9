
terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.25.0"
        }
    }
}

provider "docker" {
}

resource "docker_container" "contenedor" {
    name        = "contenedor"
    image       = docker_image.imagen.image_id 
    
    connection {
    # https://developer.hashicorp.com/terraform/language/resources/provisioners/connection
        host    = self.network_data[0].ip_address
        type    = "ssh" # "winrm"
        port    = 22
        user    = "root"
        password = "root"
    }
    # Los provisionadores remotos ejecutan codigo en un entorno remoto.
    # En qué entorno? en el que están definidos? SI o NO... donde yo quiera
    # Este tipo de provisionadores siempre deben llevar una marca previa llamada "connection"
    provisioner "remote-exec" {
        #on_failure = continue
        inline  = [
                        "echo Dentro del contenedor",
                        "echo Dentro del contenedor > /tmp/prueba.txt"
                  ]
    }
    provisioner "remote-exec" {
        #on_failure = continue
        script  = "./miscript.sh"
        # scripts = [ "" , "" ]
    }
    
    # También requiere del bloque connection
    # Nos permite:
    # - copiar archivos al remoto
    # - generar archivos en el remoto
    provisioner "file" {
        destination = "/tmp/fichero.txt"
        source      = "./miArchivo.txt"
    }
    provisioner "file" {
        destination = "/tmp/fichero2.txt"
        content     = <<EOT
                        Soy una linea del archivo
                        Y yo otra
                        EOT
    }# En este caso, la función templatefile()
    
}

resource "docker_image" "imagen" {
    name = "rastasheep/ubuntu-sshd:latest"
}

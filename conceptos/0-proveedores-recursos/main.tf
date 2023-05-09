# En estos archivos podemos poner comenatrios, con el cuadradito, como en la bash o python

# Objetivo de este script:
# Crear un contenedor con nginx
# Para ello, primero hemos de hacernos con la imagen del contenedor de nginx (en versión ultima)
# Esos recursos que vamos a definir: CONTENEDOR e IMAGEN DE CONTENEDOR
# se los vamos a pedir a un provider

terraform {
    # Definimos los proveedores que vamos a necesitar para nuestro script
    required_providers {
        docker = {
            # Los proveedores los descargamos del terraform registry
            source = "kreuzwerker/docker"
            version = "2.25.0"
        }
    }
}

# Con la marca provider(que tendremos una para cada provider que usemos)
# damos la configuración del proveedor
# Habrá proveedores como éste de docker que no necesiten de configuración.
# Otros, como el de amazon, o el de azure, SI la necesitan
provider "docker" {
}

# Recursos que damos de alta en el CATALOGO de recursos
#resource "TIPO DE RECURSO" "NOMBRE INTERNO PARA REFERIRINOS A EL" {
    # Configuración concreta del recurso
    # Esta configuración... y las palabras que vamos a poner aquí, dependen del TIPO DE RECURSO CONCRETO
#}

resource "docker_container" "contenedor" {
    # Qué dato me hará falta?
    name        = "minginx"
    image       = docker_image.imagen.image_id #"sha256:448a08f1d2f94e8db6db9286fd77a3a4f3712786583720a12f1648abb8cace25"
                    # Pero esta linea tiene una DOBLE MISION:
                    # - Por un lado, me sirve para indicar de dónde se saca el valor de image
                    # - Por otro lado, Para incidar a terraform que este recurso (CONTENEDOR) depende del recurso (IMAGEN)
                    #   Crear la dependencia entre los recursos
                        #depends_on = [  # Pero ESTO NO SE USA NUNCA JAMAS DE LOS JAMASES !!!! 
                        #                Cuando hay alternativa (y en el 99,999999% la hay) es una mala practica !
                        #    docker_image.imagen
                        #]
    
    env         = [
                    "VARIABLE1=VALOR1",
                    "VARIABLE2=VALOR2"
                  ]
          
    must_run    = true
    
    ports       {
                    internal = 80
                    external = 8080
    }
    
    ports       {
                    internal = 443
                    external = 8443
    }
}

# Cuando creamos UN recurso, podemos referenciarle, a través de una variable.
# El nombre de la variable lo genera terraform en automático: "TIPODERECURSO.NOMBRE"
# De cualquier recurso, puedo solicitar los datos que he introducido. 
# Para ello, puedo poner un punto adicional y el nombre del dato:
#   > docker_image.imagen.name      Para referenciar al nombre de la imagen de contenedor que he escrito
# Pero, los recursos, una vez son creados, se cargan con más información
# Esa información también es accesible mediante la misma sintaxis.
resource "docker_image" "imagen" {
    # Qué dato me hará falta?
    # repo: nginx
    # tag: latest
    name = "nginx:latest"
}

# Funcionaría?
# SI: 
# NO: IIIIII
# NPI: Ivan!
# De qué dependerá? Del orden de ejecución de los recursos
# En terraform, el orden en el que escriba los recursos, es indiferente, a terraform se la trae al peiro !
# Terraform calcula UN GRAFO DE DEPENDENCIAS ENTRE RECURSOS, grafo que podremos ver gráficamente
# Mañana es lo primero que vamos a hacer, generar el grafo de dependencias de estos recursos en PNG, SVG

# De alguna forma, necesitamos influir en ese GRAFO, para decirle a terraform que lo primero
# es la imagen de contenedor y después el contenedor
# Y eso no va a ase por poner uno delante o detrás en el fichero.
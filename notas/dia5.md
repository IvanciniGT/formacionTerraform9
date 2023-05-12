# Datos sensibles

Una variable o un output pueden contener datos sensibles

En los log de ejecución de terraform se muestran datos de variables y de outputs

Los datos (variables / outputs) marcados como sensibles no se muestran en los log.

Para marcar un dato como sensible, necesitamos añadir:

    sensitive = true

en su definición.

Esto es una decición mia en la mayoría de los casos.

Pero!!! En los outputs, si el datos que expongo provienen de un recurso que ha definido esos datos como sensibles,
Terraform me obliga a mi también a marcarlos como sensibles.

# Scripts de terraform

Una buena práctica sería que los scripts de terraform SOLO tengan llamadas a MODULOS.

## Un Modulo

Es una función reutilizable, con unos datos de entrada, que genera un conjunto de recursos en algun sitio y provee unas respuestas
                                // variables            // resources                        // provider           // outputs

## Cuando quiero desplegar una infra:

- Maquinas, con unas características: CPU, memoria, disco
- Redes, CIDR, subnets
- Firewalls
- Balanceadores

Montar un script que despliegue una infra: Y defino la infra
haciendo llamadas a unos MODULOS PROPIOS, que encapsulan la funcionalidad de la 
creación de esos recursos en UN CLOUD

En un momento dado puede ser que acabe con 500-5000 scripts

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

# Monto un script

Para desplegar una infra.

Cuantas veces querre ejecutar ese script? 
Si fuera solo 1, montaría un script? NO
Muchas... para qué esas muchas?
- Para evolucionar (mantener) esa infra <<<< Con el fichero .tfstate (ES CRITICO !)
- Para desplegar más infras en otros sitios, iguales a esta.
    - Por un lado necesitariamos ficheros de config diferentes (variables)
    - Cada entorno necesita tener su propio tfstate


# Workspace

Espacio de trabajo independiente dentro de un script de terraform, que contiene su propio archivo tfstate

Si no especifico nada, por defecto se trabaja en el ws: default <<< ESO ES UNA MUY MALA PRACTICA

# Submodulos de git

REPO git: Script

REPO git entorno1
    Fichero de variables del entorno1
    submodulo de git -> REPO git: Script
    

REPO git entorno2
    Fichero de variables del entorno2
    submodulo de git -> REPO git: Script    
    
Si el entorno es por cliente -> Repos diferentes
Si entorno pro, entorno test para un mismo cliente -> Mismo repo
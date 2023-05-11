
# Terraform

Herramienta de software que fabrica la gente de Hashicorp, que nos ofrece:
- Un lenguaje DECLARATIVO HCL (HashiCorp Languaje) para definir SCRIPTS
- Un intértrete con el que realizar tareas sobre nuestro SCRIPT

## Para que sirve?

Crear AUTOMATIZACIONES.

###Qué hagan qué?

Para gestionar (adquirir/liberar/actualizar) recursos contra unos proveedores.

| Recursos                  | Proveedores       |
| ------------------------- | ----------------- |
| Máquina virtual, INFRA    | Cloud, VMWARE     |
| Contenedores, Pods        | Kubernetes        |
| BBDD                      | MARIADB           |
| Entrada DNS               | Servidor DNS.     |
| Clave ssh                 | ?                 |

El principal uso es el despliegue de infras en clouds... aunque desde luego NO ESTA RESTRINGIDO A ESO !

## Automatización? 

Montar un programa que ejecute unas tareas que antes realizabamos manualmente.
Un tipo de programa muy concreto: SCRIPT

---

# Dev--->ops

Una filosofía, una cultura, un movimiento en PRO de la AUTOMATIZACION!
Quiero automatizar TODO lo que sea AUTOMATIZABLE entre el DESARROLLO y la OPERACIÓN de un SISTEMA

Devops viene en reemplazo de lo que antes llamábamos Software Development Managment Cycle

                                Automatizable?      Herramientas
    Plan                                x
    Code                                ~
    Empaquetado(build)                  √           JAVA:   Maven, gradle, sbt
                                                    PYTHON: Poetry, pip
                                                    C#:     msbuild, dotnet, nuget
                                                    JS:     yarn, npm
    Test
        Diseño                          ~
        Ejecución                       √           Selenium, Katalo, Appium, JMeter, LoadRunner, Sonar, SoapUI, Postman...
        ¿Donde las hago?
            Las hago en la máquina del desarrollador?   NO. No me fio de ese entorno... está maleao'
            Las hago en la máquina del tester?          NO. No me fio de ese entorno... está maleao'
            Las hago en un entorno previo: PRE, Q&A, Pruebas... Integración?   antes si... ahora también... pero ha cambiao'
                Antes, ese entorno lo tenía precreado.  Hoy en día esto no lo quiero. NO ME FIO... esta maleao'
                Hoy en día: Tengo entorno de usar y tirar.
                    Terraform, ansible, kubernetes, docker , puppet, chef, vagrant
    <<<<< Si automatizo hasta aquí? INTEGRACION CONTINUA                            CI
    Release
    <<<<< Si automatizo hasta aquí? ENTREGA CONTINUA        Continuous Delivery     CD
    Deployment
    <<<<< Si automatizo hasta aquí? DESPLIEGUE CONTINUA     Continuous Deployment   CD
        VA en un entorno de PRO! Y también automatizo su creación y gestión.
    Operation
    Monitor
    
Si automatizo todo esto... ya lo tengo todo automatizado? o me falta algo?

La llamada a esas automatizaciones y su orquestación: Nos faltan los Servidores de Automatición | CI/CD
- Jenkins
- Travis
- GitlabCI/CD
- BAMBOO
- TeamCity
- Azure Devops

# Por qué quiero automatizar en nuestro caso, la generación de una infra?
- Agilizar el proceso? Ocurre esto? SI? Siempre?
    Montar un script de Terraform es un TRABAJON DE COJONES !!!!
    Lo haré si.... me compensa:
        - Si voy a hacer la tarea muchas veces:
            - Porque tenga varios clientes
            - Porque la infra vaya cambiando a lo largo del tiempo y haya que mantenerla
    - En estos escenarios, cuando hago esto MUCHAS VECES, es donde un programa es más ágil y ayuda a evitar errores humanos

# Entornos de PRODUCCION

## Alta disponibilidad

"Tratar" de garantizar un determinado tiempo de servicio (normalmente pactado contractualmente)
"Tratar" de garantizar la NO PERDIDA DE información

Estrategía: REDUNDANCIA

## Escalabilidad

Capacidad de ajustar la infra a las necesidades de cada momento:

App2:
    Día 1:      100 usuarios        |
    Día 100:    1000 usuarios        >  Escalabilidad Vertical: MAS MAQUINA !
    Día 1000:   10000 usuarios      |
    
App3: Este es el hoy en día: INTERNET
    Hora n:      100 usuarios        |
    Hora n+1:    1000000 usuarios     >  Escalabilidad horizontal: MAS MAQUINAS !
    Hora n+2:    10000 usuarios      |
    Hora n+1:    2000000 usuarios    |  

Quién ofrece esa agilidad a la hora de contratar INFRA? Clouds

## CLOUD?

Conjunto de servicios que ofrece un proveedor a través de INTERNET, con unas características muy concretas:
- Pago por uso
- Gestión automatizada (sin intervención humana) al menos de su lado

Esos servicios pueden ser de distintos tipos:
- Infraestructura (computación, comunicaciones, almacenamiento): IaaS
- Plataforma (base de datos, kubernetes, sistema de mensajería): PaaS
- Software (gmail, office365): SaaS

Terraform nos permite automatizar NUESTRO TRABAJO con respecto al CLOUD

---

# Hay alternativas a terraform para automatizar la creación de infras en clouds?

SI:
- awscli
- azcli
- ....

Por qué esas herramientas, a pesar de ser OFICIALES! se usan mucho menos que terraform?
POR USAR UN LENGUAJE DECLARATIVO, al igual que todas las herramienats que lo están petando:
- Ansible
- Kubernetes

# Lenguaje imperativo

    oye Felipe, SI HAY UN MUEBLE DEBAJO DE LA VENTANA:      Condicionales
        Quita el mueble                                     Imperativo
    Felipe, si no hay silla,                                Condicional
        vete al Ikea a comprar una silla y luego                Imperativo
    Felipe! pon una silla debajo de la ventana !            Imperativo
    aws! describe instances                                 Imperativo
    
    Estamos muy acostumbrados a lenguajes imperativos, pero no nos gustan nada!
    ps1, bash, python, awscli, azure cli... TODO LENGUAJE IMPERATIVO = RUINA !!!!!!
    
# Lenguaje declarativo

    oye Felipe, debajo de la ventana ha de haber una silla!

# Por qué terraform se usa tanto para automatizar la creación de infras en clouds?

Si yo defino una infra en AWS... la puedo pasar luego tal cual a AZURE? Ni de coña! 
Me toca reescribirlo ENTERO !

# En lenguaje DECLARATIVO HCL (HashiCorp Languaje)

Es un lenguaje cuya sintaxis es una mezcla json y yaml.
Con este lenguaje definiremos CATALOGOS DE RECURSOS.
Sobre esos CATALOGOS DE RECURSOS posteriormente aplciamos comandos (ORDENES)
- Crea esos recursos
- Borra esos recursos

## Qué es un script en terraform?

Un CATALOGOS DE RECURSOS definido en una CARPETA !
Esa carpeta contrendrá 1 o muchos archivos, llamados como me de la real gana... pero con extensión .tf

Hay un convenio con respecto a los nombres:
- main.tf
- variables.tf
- versiones.tf
- outputs.tf

Terraform, cuando le pida que ejecute una ORDEN sobre un SCRIPT, juntará TODOS ESOS ARCHIVOS en 1: MI CATALOGO DE RECURSOS

En esos archivos vamos a tener una serie de marcas de primer nivel, que hemos de aprender:
- terraform     LUNES
- provider      LUNES
- resource      LUNES
- output        MARTES
- variable      MIERCOLES: Es lo más complejo CON MUCHA DIFERENCIA QUE TIENE TERRAFORM 
-----
    resources
        provisioners
- locals        JUEVES: Otro tipo de variables
----
- module        JUEVES
- data          VIERNES

Terraform me pone fácil el crear una infra en un cloud? Me facilita el proceso? 

En nada... Me complica un huevo la vida... Las pantallitas son mucho más fáciles

# El intértrete terraform

Que nos permitirá hacer operaciones sobre los scripts:
- init          Descargar los providers que necesite mi script
                y algo más que os contaré el Jueves!
- validate      Valida la sintaxis de un script
- refresh       Se conecta con el proveedor para preguntar por el estado real de los recursos
- plan          Determina el plan de ejecución para conseguir el estado DESEADO de mi catalogo de recursos (SCRIPT)
                    Esto pasa de lenguaje DECLARATIVO a IMPERATIVO
- apply         Ejecuta un plan para conseguir?
                - Creando recursos
                - Borrando recursos
                - Modificando recursos
- destroy       Desmantela los recursos (desmantela una infra)
                En el curso, vamos a usar mucho el destroy. En real (producción) esto no debería usarse NUNCA JAMAS
                hasta que el proyecto llegue a su fin!
- ...

# Desde el punto de vista de Terraform, qué es un provider?

AWS: Cloud de Amazon? es un provider de terraform? Nop

Un provider, desde el punto de vista de terraform, es un programa con el que terraform
sabe comunicarse para solicitar la gestión de unos recursos.


                                                                                BAJO MI PUNTO DE VISTA
                                        apply                                       v Este es mi provider
    SCRIPT de terraform  ->  terraform <COMANDO> -> provider de aws -> awscli -> Cloud de Amazon (AWS)
        carpeta/                                     programa que descargo en local
            *.tf                                     con el que terraform sabe comunicarse

# Estados en Terraform

## Estado real/actual << ? Este se maneja en Terraform? NO

Los recursos que REALMENTE existen en un momento dado en un proveedor

## Estado que terraform conoce del proveedor

Los recursos que TERRAFORM cree que existen en un momento dado en un proveedor

## Estado deseado

El que quiero alcanzar. Los recursos que en definitiva voy a querer tener en un(os) proveedor(es)


    Estado deseado      Estado que terraform cree que hay en el proveedor       Estado que hay en el proveedor
        Recurso1
        Recurso2

## Donde están definidos esos estados?

    En el script,       Se guarda en un fichero (o varios)                      En el proveedor... el sabrá
    en mi carpeta           terraform.tfstate
    
## Cuando se hace un plan, que estamos haciendo realmente?

Comparar el estado deseado con el Estado que terraform cree que hay en el proveedor.
Y calcular las operaciones que hay que hacer en el proveedor para conseguir que el estado real sea mi estado deseado.

Pero para ello, debo asegurarme de qué? 

Estado que terraform cree que hay en el proveedor   ==   Estado que hay en el proveedor

Eso es otra operación que hay en terraform: terraform refresh

En general, una buena politica es:
- SI USO TERRAFORM, SOLO USO TERRAFORM para gestionar una infra.
- Como se me ocurra irme al proveedor y hacer allí maldades sin que terraform se entere, voy a sudar ! un montón!
    Esto voy a tratar de evitarlo

## Infraestructura como código

- Tengo definida la infra (mi catalogo de recursos) en un código escrito en lenguaje HCL
- Código de un programa, que voy a tratar como cualquier otro programa:
    - Dónde se guarda un programa? En un repo de un SCM (git-Bitbucket)
    - Voy a tener evrsiones de la infra... que pueden evolucionar en paralelo!

## Qué me da un SCM ?

Entre otras cosas: CONTROL DE VERSIONES

Con un sistema de backup, puedo tener versiones? SI
Que puede ser ir creandome cada (minuto, hora, dia, semana) un triste ZIP con el estado actual de una carpetilla que tengo (mi script)

Entonces, que me ofrece como plus un SCM que lo diferencia de un sistema de backup? 
La posibilidad de tener versiones diferentes en paralelo, versiones que evolucionan en paralelo: RAMAs

Mi infra va air evolucionando, irá teniendo versiones!
Pero esas versiones, además, podrán evolucionar en paralelo.

INFRA DE MI PRODUCTO A
    ProductoA v 1.0 -> Llevará asociada una determina versión de la infra 1.0
    ProductoA v 1.1 -> quizás es necesaria una nueva infra                1.1
    ProductoA v 3.0 -> quizás es necesaria una nueva infra                2.0

Pero quizás esas infras las creo en diferentes clientes
    Producto A - Cliente a 1.0a
    Producto A - Cliente b 1.0b (que tiene más recursos... hacen falta)

---

Llegados a este punto, nos toca comenzar con Terraform, a montar scripts... o aún no!

Quizás antes debemos definir, qué vamos a AUTOMATIZAR !

    2 RECURSOS              --->            1 PROVEEDOR
    contenedores                            docker
    imagenes de contenedor

---

# Contenedores

Un entorno aislado dentro de un SO con kernel Linux donde ejecutar procesos !
Entorno aislado:
- Tiene su propia configuración de red -> Sus propias IPs
- Tiene sus propias variables de entorno
- Tiene su propio sistema de archivos
- Puede tener limitación de acceso al hierro (hardware)

Los contenedores los creamos desde una imagen de contenedor.

A la hora de crear un contenedor, opciones, parámetros, cosas típicas que configuramos?
- nombre
- imagen que uso
- volumenes (son rutas en el FS del contenedor que realmente tienen su almacenamiento fuera del FS del contenedor)
- redirecciones de puertos que hacemos a nivel del host
- variables de entorno

# Imagen de contenedor

Un triste archivo comprimido (tar) que incluye (habitualmente) una estructura de carpetas compatible con POSIX 
(bin, opt, var, tmp, boot, home....)
Y en esas carpetas vienen instalados una serie de programas
Con configuraciones ya establecidas

## Dentro de un contenedor puedo montar cualquier SO? 

Dentro de un contenedor no puedo montar ningún SO, se comparte el kernel de SO del host

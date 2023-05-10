# Terraform 

Un lenguaje declarativo HCL + comando "terraform" que nos permiten 
la gestión (alta, modificación, eliminación) de recursos en unos proveedores.

Se utiliza mucho para gestionar infras en clouds.

Nos ayuda a controlar el estado de esos recursos.

## Estado del entorno

### Estado deseado

Es el que defino en mi script

### Estado real

Dentro del proveedor

### Estado que terraform conoce del proveedor

Se almacena en unos ficheros llamados terraform.tfstate

        Estado deseado   - [apply] >    Estado real 
            ^                                |
         [plan]                          [refresh]
            |                                v
        Estado que terraform conoce del proveedor

# Lenguaje HCL

Es de tipo declarativo <<< ESTA ES LA GRAN GRACIA DE TERRAFORM !!!!!
Eso me es cómodo para trabajar!

## Idempotencia

Siempre consigo el mismo estado final, con independencia del estado inicial.
El "estado real 2" no depende del "estado real 1" solo del "Estado deseado"

## Scripts = Catalogo de recursos

Es una carpeta que contiene archivos .tf, que se pueden llamar de cualquier forma:
- main.tf
- versions.tf
- outputs.tf
- variables.tf

Dentro de eso archivos encontramos ciertas marcas:
- terraform     Declarar los proveedores (1) que necesitamos
- provider      Configurar esos proveedores
- resource      Declarar recursos que queremos en el proveedor externo
- output        Es la forma de exportar datos del estado conocido a terceros
                Hay otras... pero no las queremos, por los problemas que me pueden generar
- variable      Parametros/Argumento a nuestro script
- locals        "Variables" de uso interno
- data          Una query que hacemos al proveedor externo para obtener
                información de recursos allí almacenados, pero no gestionados por mi o si!
- module        ???

### Proveedor (1)

Un programa que descargamos y permite a terraform gestionar recursos en un proveedor externo.

## Sobre esos scripts

Aplicamos operaciones con el comando terraform:
- init          Descargar el proveedor
                + ???
- validate      Validar la sintaxis del script
- refresh       Igual el estado que terraform conoce con el estado real
- plan          Compara el estado deseado con el que terraform conoce para
                calcular un plan de ejecución (operaciones necesarias en el proveedor externo para 
                conseguir ele stado deseado)
- apply         Ejecutar las operaciones de un plan
- destroy       Desmantelar el catalogo de recursos

# Hash?

Es el resultado de aplicar sobre unos datos (una secuencia de bytes) una función de huella!

Los algoritmos de hash generan un dato de salida, desde un dato de entrada de forma que:
- Siempre se genera el mismo dato de salida para el mismo dato de entrada
- Que haya poca probabilidad de generar el mismo dato de salida para distintos datos de entrada
- Desde el dato de salida no puedo regenerar el dato de entrada

Desde que teneis 10 años, la letra del DNI?

23.000.000 -> Tomar el resto al dividir entre 23 -> 0 -> T

    23000000 | 23
             -----------
           0   1000000
           
    Probabilidad de colisión: 1/23
    
# Configuración de recursos

En la docu, para cada tipo de recurso me viene:
- Los datos que puedo suministrar (configurar)
- Los datos que puedo leer

Esos datos, pueden tener distintas naturalezas. Esos tipos de datos, se indican en la documentación.

# TIPOS DE DATOS EN TERRAFORM

- string        Texto                   "Hola, spy un texto"
- number        Numero                  3       8.9
- boolean       Valor lógico            true    false
- list(...)     Secuencia de valores    [1, 2 ,3 ]           # list(number)
                ORDENADAS               [true, false, true ] # list(boolean)
                Puedo acceder a un dato de una lista a través de su posición!
- set(...)      Secuencia de valores    [1, 2, 3 ]           # set(number)
                DESORDENADAS
                NO puedo acceder a un dato de un set a través de su posición!   ERROR !
                Solo puedo iterar sobre los valores: DAME OTRO !
- map(...)      Diccionario, Map, Array asociativo
                secuencia no ordenada de datos
                donde puedo acceder a cada dato a través de una clave
                                        {
                                            "dato1" = "valor1"
                                        }
                Las claves siempre son textos en terraform

Para todos estos tipos de valores, la sintaxis en terraform siempre es la misma:
> Pongo el nombre del dato, después un signo igual, y después el valor...
> OJO: El valor escrito según el tipo de datos.

Hay un tipo adicional de datos, que nos va a aparecer cundo configuramos recursos:
- block         ESTOS SON DIFERENTES A LOS ANTERIORES
                Los block siempre los vais a encontrar como: Block list | Block set. Nos da igual !
                Y siempre tienen un esquema asociado, que define nuevos campos, para este campo

En este caso, al escribir el campo dentro del recurso de terraform, usamos la siguiente sintaxis:

    campo {
        # Aqui dentro pondré los nuevos campos asociados a este campo
    }

Si quiero dar varios valores para ese campo, repito el bloque completo !

# Outputs

Imaginad que estoy montando un script... con el que defino una infra.
En mi caso, la infra es un CONTENEDOR!

## PUNTO 1: Para que hago esto? 

Para que ... npi!!!
Alguien lo necesitará !(quizás ese alguien soy yo)
Lo importante es entender que AQUI (con lainfra creada) no acaba el mundo !

Creo la infra y YA? Mi trabajo ha concluido ? NO he acabado !
Qué más hace falta que YO HAGA !!??!!??

Pasar datos a los que vienen detrás!

## PUNTO 2: Quién va a ejecutar mi script de terraform? YO? 
Ni yo ni alguien otro !

Quién debe encargarse en última instancia de ejecutar esto? JENKINS ! o similar
Esa tarea debe estar automatizada! ESTE ES EL OBJETIVO, este es el CAMINO !

Y ese servidor que he creado, posteriormente entrará un playbook de ansible a plancharlo!
Quién va a ejecutar el script de Ansible? YO? Mi primo? Terraform? JENKINS ! o similar

## RESUMEN

De alguna forma he de pasar datos de TERRAFORM a ANSIBLE !

Le quiero pasar la IP de mi contenedor.


        SCRIPT TERRAFORM  ---> PLAYBOOK DE ANSIBLE
        
    Hago así la comunicación de los datos? NO
    NUNCA lo haría así: QUIERO COMPONENTES DESACOPLADOS <<<. IMPORTANTISSISISISISISISISISISMO !!!
    

        JENKINS -------------------    
         v ^                     v^
        SCRIPT TERRAFORM       PLAYBOOK DE ANSIBLE

Tiene ya acceso el Jenkins a la IP del contenedor? TOTALMENTE !
La ip está en el fichero terraform.tfstate... Es un fichero JSON

ESTA ES LA SOLUCION. NO HAY OTRA!

El problema es de dónde leo la IP dentro del fichero <<<<

# Versiones de software

2.25.0
  V
3.2.0

2.25.0                  Cuando se incrementan?
 - MAJOR:   2           Cambio que no respetan retrocompatibilidad
 - MINOR:   25          Nuevas funciones
                        Marcar funciones como obsoletas
                            + Arreglos de bugs
 - PATCH:   0           Arreglos de bugs
 
## VErsiones de imagenes (VM o de contenedores)

# latest             Eso no lo pondría nunca. Por qué? No tengo control de lo que instalo
# 1.24.0-perl        Esto tampoco. Por qué? Quiero los bugs arreglados
# 1-perl             Esto tampoco. Por qué? No necesito nuevas funcionalidad... mi entorno
#                     Tiene programas que requieren de unas funcionalidades. No quiero nuevas que no uso y pueden traer bugs
# 1.24-perl          Eto SI. Tiene las funcionalidades que necesito y los ultimos bugs arreglados


 ## Extraer datos

Siempre se extraen del fichero .tfstate

NUNCA JAMAS los extraigo del bloque "resources".
No controlo la estructura de ese bloque. Los datos están... y son accesibles:
> cat terraform.tfstate | jq ".resources[0].instances[0].attributes.ip_address"
>  "172.17.0.2"

Pero si hago esto, me expongo a que en el futuro cambie lña estructura que genera el proveedor...
Y se me jodan todas las inetgraciones..

en nuestro caso al subir la versión del provioder de docker, he de cambiar ese comando en Jenkins.
> cat terraform.tfstate | jq ".resources[0].instances[0].attributes.network_data[0].ip_address"
>  "172.17.0.2"

FOLLON DE MANTENIMIENTO!!!

La alternativa es generar OUTPUTS, que son datos que se guardan en el fichero .tfstate en una estructura que YO CONTROLO (defino)
De ahí puedo sacar los datos fácilmente con:
> terraform output --json direccion_ip
>  "172.17.0.2"

La ventaja es que si el proveedor cambia en un momento dado:
Puedo cambiar de donde se rellena el valor del output... SIN que cambie la estructura que se 
genera en el fichero .tfstate

Pero CONTENGO el cambio a nivel de mi script... es decir,
NO TENGO NADA QUE CAMBIAR FUERA DEL MISMO:
En jenkins seguirá funcionando el mismo comando de antes:
> terraform output --json direccion_ip
>  "172.17.0.2"

MORALEJA: NUNCA JAMAS EN LA VIDA, leer datos del bloque "Resources" del fichero .tfstate
PAN PARA HOY y RUINA PARA MAÑANA  !!!!
> Los comandos terraform state, (que lo que hacen es leer el bloque resources del fichero)
> DEBO USARLOS CON EXTREMO CUIDADO !

---

# VARIABLES

Me permiten parametrizar un script:

## Cuando monto un script? Cuando solo necesito INSTALAR UN entorno? NO

Cuando quieroa GESTIONAR (cambios) uno o VARIOS entornos
pre / pro /desarrollo

Imaginad que montamos un script de terraform para gestionar la infra de un sistema que desarrollamos
Desa / Pre / Pro
Pero además... llamadme loco ! vosotros estais desarrollando un programa = SCRIPT !
Y para vosotros, todos esos entornos: desa / pre / pro son entornos de PRODUCCION !
Quiero decir... vosotros necesitais vuestro propio entorno de DESARROLLO !

## Definición de variables

Al definir una variable hemos de suministrar:
- nombre            variable "nombre" {...}
- descripcion       description = <string>
- tipo de datos     type = 
                        - string
                        - number
                        - boolean
                        - set(...)
                        - list(...)
                        - map(...)
                        - object            Es como un mapa... pero:
                                                - las claves van prefijadas
                                                - asociado a cada clave puedo tener un tipo de datos diferente
                            object({
                                interno     = number
                                externo     = number
                                ip          = optional(string, "127.0.0.1")
                                protocolo   = optional(string, "tcp")
                            })

## IMPORTANTE

Terraform NUNCA JAMAS va a ejecutar un script si hay variables carentes de valor!

## Formas de suministrar valores de una variable en terraform:

1.  Desde linea de comandos... Con el argumento --var NOMBRE=VALOR
    Os gusta esta forma? NO
    Ya que... Dónde queda registrado el valor de las variables que he usado en una ejecución?
    En ningún sitio. No hay registro.
    De hecho yo quiero saber con que valor he ejecutado el script:
        - Hoy
        - Ayer
        - Hace 2 semanas
        - Hace 1 mes
        - La primera vez
    Quién me ayuda con esto? Un sistema de control de código fuente SCM: GIT 
    Y para que me ayude con este, los valores deben estar en un FICHERO .tfvars

    Sirve para...
        - pruebas rápidas
        - Cuando no quiera dejar huella, Por ejemplo: Cuando paso un dato sensible

2.  Desde un fichero de variables ... Con el argumento --var-file FICHERO
    Se definen los valores de la variable con sintaxis HCL
    Estos si nos gustan!

3. En un fichero .auto.tfvars
    Estos ficheros se cargan en automático. No hay que suministrarlos

4. Se miraría en la propiedad default de la variable.... YA VEREMOS CUANDO !

5. Si aún así una variable no tiene valor: SE PIDE POR CONSOLA

6. Si aún así, terraform no consigue el valor de una variable: SE PARA !

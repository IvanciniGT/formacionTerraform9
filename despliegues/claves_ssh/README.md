# Para acceder a una maquina linux

Claves ssh: Par de claves: Publica + Privada

En mi máquina tengo LA PRIVADA
Y en los servidores a los que quiero conectar AÑADO mi clave PUBLICA dentro de un fichero que se llama: 
~/.ssh/authorized_keys

ssh , el servidor me pide confirmación de ser quien soy... Y para ello me manda un mensaje
Yo debo encriptar ese mensaje con mi clave privada y mandarlo al servidor
El servidor desencripta el mansaje con la clave publica asociada
Y si el mensaje conincide con el original que ma manda el servidor, me dejan hacer login

Vamos a generar claves... con un script de Terraform 

Usaremos el provider hashicorp/tls

Para crear un apr de claves publica/privada:
    algorithm (String) RSA, ECDSA, ED25519.
    ecdsa_curve (String) P224, P256, P384, P521. (default: P224).
    rsa_bits (Number) 2048.
---

Queremos un script que permita generar claves ssh. 

Debe ser parametrizable:
- algoritmo y su configuración              algoritmo / configuracion
- carpeta de los ficheros de las claves     directorio_ficheros_claves    
-                                           regenerar_claves_si_existen               
Debe validar las variables/parametros

Cuando las claves se generen, se exportarán:
- output
- en ficheros dentro de una carpeta
    clavePrivada.pem
    clavePrivada.openssh
    clavePublica.pem
    clavePublica.openssh

Las claves se exportan en 2 formatos: openssh, pem

El sistema debe verificar si ya existen claves en esa carpeta. 
Si existen y no SE SOLICITA que se regeneren, se cargan y se exportan como outputs
Si no existen se generan, igual que si existen y se solicita que se regeneren
# Cluster de servidores web

Servidor1   <<<
Servidor2   <<<     Balanceador de carga   <<<    Clientes
Servidor3   <<<

---

# Provisioners

Son programas que se ejecutan asociados al ciclo de vida de un recurso:
- Cuando un recurso es creado/modificado
- Cuando un recurso es eliminado

Los provisionaros SIEMPRE VAN ASOCIADOS A UN RECURSO, de hecho, se definen dentro de un recurso
Un recurso puede definir MULTIPLES provisionadores

En terraform a día de hoy hay 3 TIPOS DE PROVISIONADORES:
- local-exec:       Ejecutar programas en la máquina donde estoy corriendo terraform
- remote-exec:      Ejecutar programas en un sitio remoto... bien sea el recurso donde está definido o en otro.
- file :            Copiar archivos a un sitio remoto

## USO?
- Pruebas: CASO TIPICO DE USO !
- Configurar el remoto
    - Quiero que terraform configure esa máquina? Para eso está Ansible! Puppet, Chef, Salt
    - Preparar el entorno para el que viene detrás!
        - Montar ssh, copiar un fichero de clave publica ssh, abrir un puerto...
            Montando una IMAGEN que ya tenga eso de serie
- Llamar a Ansible, puppet, Chef: RUINA GIGANTE !!!!!
    - Quien se encarga de eso? Un orquestador: Jenkins

---

# He montado un entorno con una imagen que lleva dentro un servidor web...
# Me quiero asegurar que aquello ha quedado operativo


1º ping a la maquina
2º dentro de la maquina si el puerto de turno está abierto
3º si el curl me funciona desde dentro de la maquina
4º si el curl me funciona desde fuera de la maquina - NOK
    - firewall ***
    - dns

curl IP_ENTORNO:PUERTO
    Si falla? Donde está el problema? 
        - No tengo curl
        - No está corriendo nginx
        - El puerto está capao por un firewall
        - La maquina no está accesible (problema de conf. de red)
        - La maquina no arrancó

> Ejemplo 2

Monto un servidor redhat

Que prueba(s) hago? 
- ping a la maquina
- tengo conexión por ssh
- tengo conexión por winrm

---

# Pruebas

## Para qué sirven las pruebas?

- Verificar el cumplimiento de requisitos
- Si algo falla, quiero aportar luz

## Niveles de pruebas

- Unitarias     Se centra e un componente AISLADO
- Integración   Se centran en comunicaciones entre componentes
- Sistema       Se centran en el comportamiento del sistema
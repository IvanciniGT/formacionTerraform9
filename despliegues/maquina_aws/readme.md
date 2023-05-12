# Crear una maquina en AWS

Si lo hiciera manualmente:
1- Configurar en AWS la región
2- EC2> Instancias > lanzar instancia
3- Buscar imagen:
    ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325
    ami-00aa9d3df94c6c354
    Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-03-25
    
    Plataforma: Ubuntu
    Arquitectura: x86_64
    Propietario: 099720109477
    Fecha de publicación: 2023-03-25
    Tipo de dispositivo raíz: ebs
    Virtualización: hvm
    Habilitado para ENA: Sí
    Modo de arranque: legacy-bios
4- Tipo de maquina: t2.micro



Terraform me facilita el proceso de creación de una máquina en AWS? En nada. Me lo pone más complicado

Me exige saber más de aws:

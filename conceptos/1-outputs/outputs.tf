
output "direccion_ip" {
    value = docker_container.contenedor.network_data[0].ip_address
}
# cat terraform.tfstate | jq ".outputs.direccion_ip.value"
# terraform output direccion_ip
#  La salida de este comando es en sintaxis HCL

# terraform output [ --json | --raw ] direccion_ip
# Más cómodo!

# En nuestro caso, este comando configuro en Jenkins:
# $ terraform output --raw direccion_ip

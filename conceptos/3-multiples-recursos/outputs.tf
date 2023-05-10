
output "direcciones_ip" {
    value = [ for contenedor in docker_container.contenedor: 
                    contenedor.network_data[0].ip_address ]
}
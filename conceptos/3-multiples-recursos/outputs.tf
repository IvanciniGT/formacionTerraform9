
output "direcciones_ip" {
    value = [ for contenedor in docker_container.contenedor: 
                    contenedor.network_data[0].ip_address ]
}
# Quiero una lista con las IPs de los contenedores personalziados

output "direcciones_ip_contenedores_mas_personalizados" {
    value = [ for contenedor in docker_container.contenedor_personalizado: 
                    contenedor.network_data[0].ip_address ]
}
output "direcciones_ip_contenedores_mas_personalizados_como_texto" {
    value = join("\n", [ for nombre, contenedor in docker_container.contenedor_personalizado: 
                    "${nombre}=${contenedor.network_data[0].ip_address}" ])
}
terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "3.0.2" #2.25.0"
        }
    }
}

provider "docker" {
}
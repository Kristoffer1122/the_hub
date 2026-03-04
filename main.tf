# Root Terraform configuration to run both frontend and backend containers

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# ============ Variables ============

# Frontend variables
variable "frontend_container_name" {
  description = "Name of the Next.js frontend container"
  type        = string
  default     = "nextjs_frontend"
}

variable "azure_openai_endpoint" {
  description = "Azure OpenAI endpoint"
  type        = string
  sensitive   = true
}

variable "azure_openai_deployment_name" {
  description = "Azure OpenAI deployment name"
  type        = string
  default     = "scheduler"
}

variable "backend_url" {
  description = "Backend API URL"
  type        = string
  default     = "http://host.docker.internal:7878"
}

# Backend variables
variable "backend_container_name" {
  description = "Name of the Rust backend container"
  type        = string
  default     = "rust_backend"
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "MySQL user"
  type        = string
  default     = "krkja001"
}

variable "db_name" {
  description = "MySQL database name"
  type        = string
  default     = "the_hub"
}

variable "db_port" {
  description = "MySQL database port"
  type        = number
  default     = 3306
}

# ============ Backend ============

resource "docker_image" "backend" {
  name = "rust_backend:latest"
  build {
    context    = "${path.module}/backend"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

resource "docker_container" "backend" {
  image    = docker_image.backend.image_id
  name     = var.backend_container_name
  must_run = true
  env = [
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}",
    "DB_PORT=${var.db_port}",
    "DB_NAME=${var.db_name}"
  ]
  ports {
    internal = 7878
    external = 7878
  }

  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
}

# ============ Frontend ============

resource "docker_image" "frontend" {
  name = "nextjs_frontend:latest"
  build {
    context    = "${path.module}/frontend"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

resource "docker_container" "frontend" {
  image    = docker_image.frontend.image_id
  name     = var.frontend_container_name
  must_run = true

  depends_on = [docker_container.backend]

  env = [
    "AZURE_OPENAI_ENDPOINT=${var.azure_openai_endpoint}",
    "AZURE_OPENAI_DEPLOYMENT_NAME=${var.azure_openai_deployment_name}",
    "BACKEND_URL=${var.backend_url}"
  ]
  ports {
    internal = 3000
    external = 3000
  }

  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
}

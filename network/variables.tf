variable "env" {
  description = "The environment in which the Network will be created"
  type        = string
  default     = "stg"
}

variable "service" {
  description = "The service name for the resources"
  type        = string
  default     = "point-app"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "public_subnet" {
  description = "The CIDR block for the public subnet"
  type        = map(map(string))
  default = {
    a = {
      az   = "a"
      cidr = "10.0.11.0/24"
    }
    c = {
      az   = "c"
      cidr = "10.0.12.0/24"
    }
  }
}

variable "private_subnet" {
  description = "The CIDR block for the private subnet"
  type        = map(map(string))
  default = {
    a = {
      az   = "a"
      cidr = "10.0.21.0/24"
    }
    c = {
      az   = "c"
      cidr = "10.0.22.0/24"
    }
  }
}

variable "region" {
  description = "The region in which the VPC will be created"
  type        = string
  default     = "ap-northeast-1"
}

locals {
  # Fully Qualified Name
  fqn = "${var.service}-${var.env}"
}

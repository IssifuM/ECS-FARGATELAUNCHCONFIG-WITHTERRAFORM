# specifying the provider

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}



#Configure the AWS Provider. ie what region we are using
provider "aws" {
  region = var.region-name
}

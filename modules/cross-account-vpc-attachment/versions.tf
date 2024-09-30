terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.69.0"

      configuration_aliases = [
        aws.owner
      ]
    }
  }
}

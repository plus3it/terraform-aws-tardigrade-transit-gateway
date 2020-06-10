terraform {
  required_version = "~> 0.12.0"
}

provider aws {
  region = "us-east-1"
}

provider aws {
  region  = "us-east-1"
  profile = "owner"
  alias   = "owner"
}

module "create_attachment" {
  source = "../../"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  create_tgw_attachment = false
}

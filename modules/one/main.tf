terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.2"
      configuration_aliases = [aws.one]
    }
  }

  required_version = ">= 1.1"
}

data "aws_region" "default" {}

data "aws_region" "one" {
  provider = aws.one
}

resource "local_file" "foo" {
  content  = <<EOF
    default provider region: ${data.aws_region.default.name}
    aws.one provider region: ${data.aws_region.one.name}
  EOF
  filename = "${path.module}/foo.bar"
}

module "child" {
  providers = {
    aws.two = aws.one
  }
  source = "./modules/two"
}

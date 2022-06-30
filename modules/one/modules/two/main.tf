terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.2"
      configuration_aliases = [aws.two]
    }
  }

  required_version = ">= 1.1"
}

data "aws_region" "default" {}

data "aws_region" "two" {
  provider = aws.two
}

resource "local_file" "foo" {
  content  = <<-EOF
    default provider region: ${data.aws_region.default.name}
    aws.one provider region: ${data.aws_region.two.name}
  EOF
  filename = "${path.module}/foo.bar"
}

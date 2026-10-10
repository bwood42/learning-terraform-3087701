data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    ## Added a trailing wildcard (*) to catch version suffixes
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631", "aws-marketplace"] # Bitnami ## Added AWS Marketplace to cover any differences
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}

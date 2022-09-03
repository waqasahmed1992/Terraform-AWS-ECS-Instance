data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["al2-xilinx-vt-ga1.5-ecs-ami-bfc87610-7ae0-4ab5-93a4-a2dc8af8b8de"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "counting_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"

  name = "counting-instance"
  ami  = data.aws_ami.ubuntu.id

  instance_type               = var.instance_type
  key_name                    = aws_key_pair.counting_dashboard.key_name
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [aws_security_group.sg-counting.id]
  associate_public_ip_address = false

  user_data = file("${path.module}/scripts/counting-service.sh")
}

module "dashboard_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.3.0"

  name = "dashboard-instance"
  ami  = data.aws_ami.ubuntu.id

  instance_type               = var.instance_type
  key_name                    = aws_key_pair.counting_dashboard.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.sg-dashboard.id]
  associate_public_ip_address = true

  # The templatefile will now pull the IP from the counting module above
  user_data = templatefile("${path.module}/scripts/dashboard-service.sh", {
    counting_private_ip = module.counting_instance.private_ip
  })

  # Ensure the counting instance exists first
  depends_on = [module.counting_instance]
}
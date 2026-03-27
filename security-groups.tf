resource "aws_security_group" "sg-dashboard" {
  name = "${var.prefix}-dashboard-security-group"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9002
    to_port     = 9002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-dashboard-security-group"
  }
}

resource "aws_security_group" "sg-counting" {
  name   = "${var.prefix}-counting-security-group"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Still allow SSH for debugging
  }

  ingress {
    from_port       = 9003
    to_port         = 9003
    protocol        = "tcp"
    # ONLY allow the dashboard security group to talk to this port
    security_groups = [aws_security_group.sg-dashboard.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-counting-security-group"
  }
}
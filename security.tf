
### Security

# ALB Security group
# # Allow access to ALB from VPC IP space
resource "aws_security_group" "lb" {
  name        = "dcm"
  description = "controls access to the ALB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["172.31.0.0/16"]  ## allowed for only VPC CIDR
  }

  ingress {
    protocol    = "tcp"
    from_port   = 5000
    to_port     = 5000
    cidr_blocks = ["172.31.0.0/16"]   ## allowed for only VPC CIDR
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["172.31.0.0/16"]   ## allowed for only VPC CIDR
  }
  
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["172.31.0.0/16"]   ## allowed for only VPC CIDR
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["172.31.0.0/16"]   ## allowed for only VPC CIDR
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]    ## Outbound opened 
  }
}

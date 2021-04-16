### Security

# ALB Security group
# # Allow access to ALB from VPC IP space
resource "aws_security_group" "lb" {
  name        = "dcm-sg"
  description = "controls access to the ALB"
  vpc_id      = "${var.vpc_id1}"

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]   ## allowed for Ingress
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]    ## Outbound opened 
  }
}

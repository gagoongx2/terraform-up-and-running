
resource "aws_security_group" "instance" {
  name = var.security_group_name
  ingress                = [
    {
      description      = "server"
      cidr_blocks      = [ "0.0.0.0/0", ]
      from_port        = var.server_port
      to_port          = var.server_port
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    },
    {
      description      = "ssh"
      cidr_blocks      = [ "0.0.0.0/0", ]
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]
}


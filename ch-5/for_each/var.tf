variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-my-instance"
}

variable "nickname" {
  description = "Nick name"
  type = string
  default = "gawoo"
}

variable "server_list" {
  description = "Server List for provision"
  type = map(string)
  default = {
    server1 = "bastion"
    server2 = "registry"
    server3 = "api"
  }
}

variable "server_port" {
  description = "Server port"
  type = number
  default = "9090"
}

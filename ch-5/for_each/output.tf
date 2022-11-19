
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
output "debug" {
  value = aws_instance.server.*
  description = "debug"
}

output "public_ip" {
  value = {for k, v in aws_instance.server : k => v.public_ip}
  description = "The public IP address"
}

output "public_dns" {
  value = {for k, v in aws_instance.server : k => v.public_dns}
  description = "The public dns"
}

output "all_public_ip" {
  value = "%{for k, v in aws_instance.server}${k} => ${v.public_ip}\n %{endfor}"
  description = "The public IP address"
}


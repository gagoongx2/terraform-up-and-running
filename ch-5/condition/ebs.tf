
resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  for_each = var.use_volume ? var.server_list : {}
  size     = 40
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  for_each = var.use_volume ? var.server_list : {}
  volume_id   = aws_ebs_volume.example[each.key].id
  instance_id = aws_instance.server[each.key].id
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "server" {
  
  ami = data.aws_ami.ubuntu.id # "ami-0c76973fbe0ee100c"
  instance_type = "t2.micro"
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.instance.id]
  #count = length(var.server_list)
  for_each = var.server_list

  tags = {
    #Name = "myserver-${var.server_list[count.index]}"
    Name = "${each.key}"
    Role = "${each.value}"
  }

  # User data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead. Updates to this field will trigger a stop/start of the EC2 instance by default. If the user_data_replace_on_change is set then updates to this field will trigger a destroy and recreate
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, ${var.nickname}" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
             EOF

  user_data_replace_on_change = true

  provisioner "local-exec" {
    command = "echo local exec"
  }

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo hello world remote provisioner ${each.value} >> hello.txt",
      "hostname",
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file("~/keys/aws/aws_key.cer")
    timeout = "4m"
  }
}

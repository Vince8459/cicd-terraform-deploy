resource "aws_key_pair" "Kops-key" {
  key_name   = "Kopskey"
  public_key = file("kops.pub")
}

resource "aws_instance" "Kops-Server" {
  #count = var.instance_count
  ami                         = var.AMIS[var.REGION]
  instance_type               = "t2.micro"
  availability_zone           = var.ZONE1
  key_name                    = aws_key_pair.Kops-key.key_name
  subnet_id                   = aws_subnet.sub1.id
  vpc_security_group_ids      = [aws_security_group.kops_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Kops"
  }

  provisioner "file" {
    source      = "installkops.sh"
    destination = "/tmp/installkops.sh"
  }

  provisioner "file" {
    source      = "helm.sh"
    destination = "/tmp/helm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/installkops.sh",
      "sudo /tmp/installkops.sh",
      "chmod u+x /tmp/helm.sh",
      "sudo /tmp/helm.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("kops")
    host        = self.public_ip
  }
}

output "PublicIP2" {
  value = aws_instance.Kops-Server.public_ip
}

output "PrivateIP2" {
  value = aws_instance.Kops-Server.private_ip
}




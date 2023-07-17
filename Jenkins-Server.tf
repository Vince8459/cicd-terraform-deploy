resource "aws_key_pair" "Jenkins-key" {
  key_name   = "Jenkinskey"
  public_key = file("jenkins.pub")
}

resource "aws_instance" "Jenkins-Server" {
  #count                       = var.instance_count
  ami                         = var.AMIS[var.REGION]
  instance_type               = "t2.medium"
  availability_zone           = var.ZONE1
  key_name                    = aws_key_pair.Jenkins-key.key_name
  subnet_id                   = aws_subnet.sub1.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins"
  }

  provisioner "file" {
    source      = "installjenkins.sh"
    destination = "/tmp/installjenkins.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/installjenkins.sh",
      "sudo /tmp/installjenkins.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("jenkins")
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "jen-vol" {
  availability_zone = var.ZONE1
  size              = 4

  tags = {
    Name = "VolumeEx"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jen-vol.id
  instance_id = aws_instance.Jenkins-Server.id
}

output "PublicIP" {
  value = aws_instance.Jenkins-Server.public_ip
}

output "PrivateIP" {
  value = aws_instance.Jenkins-Server.private_ip
}


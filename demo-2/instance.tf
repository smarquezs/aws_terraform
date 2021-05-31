resource "aws_instance" "example" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.small"
  key_name = "example"

  tags = {
    Name = "example"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "file" {
    source = "webapp.conf"
    destination = "/tmp/webapp.conf"
  }

  provisioner "file" {
    source = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "file" {
    source = "passenger.sh"
    destination = "/tmp/passenger.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
      "sleep 180"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/passenger.sh",
      "/tmp/passenger.sh",
      "sleep 10"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${pathexpand("~/.ssh/example.pem")}")
  }
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

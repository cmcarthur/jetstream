resource "aws_instance" "bastion" {
  ami = "ami-fce3c696"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.public_us_east_1b.id}"
  vpc_security_group_ids = [
	"${aws_security_group.ssh.id}"
  ]
  associate_public_ip_address = true

  key_name = "${aws_key_pair.connor.key_name}"

  tags {
	Name = "bastion"
  }

  connection {
	type = "ssh"
	user = "ubuntu"
	private_key = "~/.ssh/id_rsa"
  }

  provisioner "file" {
	source = "files/test"
	destination = "/tmp/test"
  }
}

output "bastion_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

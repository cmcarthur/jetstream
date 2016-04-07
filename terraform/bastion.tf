resource "aws_instance" "bastion" {
  ami = "ami-fce3c696"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.public_us_east_1b.id}"
  vpc_security_group_ids = [
	"${aws_security_group.whitelisted_ssh.id}"
  ]
  associate_public_ip_address = true

  key_name = "${aws_key_pair.master.key_name}"

  tags {
	Name = "bastion"
  }
}

output "bastion_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

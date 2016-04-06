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
}

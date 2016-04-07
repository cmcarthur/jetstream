resource "aws_instance" "redash1" {
  ami = "ami-a7ddfbcd"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.public_us_east_1b.id}"
  vpc_security_group_ids = [
	"${aws_security_group.whitelisted_http.id}",
	"${aws_security_group.internal_ssh.id}",
  ]
  associate_public_ip_address = true

  key_name = "${aws_key_pair.master.key_name}"

  tags {
	Name = "redash1"
  }
}

resource "aws_key_pair" "master" {
  key_name = "master"
  public_key = "${file(var.public_key_path)}"
}

output "redash_url" {
  value = "http://${aws_instance.redash1.public_ip}"
}

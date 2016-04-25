#
# VPC Internal Security Groups
#
resource "aws_security_group" "internal_redshift" {
  name = "internal_redshift"
  description = "Internal Redshift Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 5439
	to_port = 5439
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "internal_http" {
  name = "internal_http"
  description = "Internal HTTP Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_ssh" {
  name = "internal_ssh"
  description = "Internal SSH Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

#
# External (Public-facing) Security Groups
#
resource "aws_security_group" "whitelisted_http" {
  name = "whitelisted_http"
  description = "HTTP Access for Whitelisted IPs"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = [
	  "${split(",", var.whitelisted_ips)}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "public_http" {
  name = "public_http"
  description = "HTTP Access for the whole world"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = [
	  "0.0.0.0/0"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "whitelisted_redshift" {
  name = "whitelisted_redshift"
  description = "Whitelisted Redshift Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 5439
	to_port = 5439
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_instance.redash1.public_ip}/32"
	]
  }
  ingress {
	from_port = 5439
	to_port = 5439
	protocol = "tcp"
	cidr_blocks = [
	  "${split(",", var.whitelisted_ips)}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "whitelisted_ssh" {
  name = "whitelisted_ssh"
  description = "SSH Access for Whitelisted IPs"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = [
	  "${split(",", var.whitelisted_ips)}"
	]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

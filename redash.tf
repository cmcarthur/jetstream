resource "aws_instance" "redash1" {
  ami = "ami-a7ddfbcd"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.public_us_east_1b.id}"
  vpc_security_group_ids = [
	"${aws_security_group.http.id}",
	"${aws_security_group.ssh.id}"
  ]
  associate_public_ip_address = true

  key_name = "${aws_key_pair.connor.key_name}"

  tags {
	Name = "redash1"
  }
}

resource "aws_security_group" "postgres" {
  name = "postgres"
  description = "Postgres Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 5432
	to_port = 5432
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}",
	  "68.83.229.62/32" # Connor Home IP
	]
  }
}

resource "aws_security_group" "http" {
  name = "http"
  description = "HTTP Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}",
	  "68.83.229.62/32", # Connor Home IP
	  "108.16.231.215/32" # Tristan Home IP
	]
  }
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "SSH Access"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}",
	  "68.83.229.62/32", # Connor Home IP
	  "108.16.231.215/32" # Tristan Home IP
	]
  }
}

resource "aws_key_pair" "connor" {
  key_name = "connor"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPTRBg8rvwhSPvc7LpSAM5miG3vUgEYFuSGrnVWNiLimEb7dDDjvvbE/x/B0yGIPS8WN02Hpn3e3zdip2SqlYP2M85WS5EsuRiKGL588RTWcuoQbiRkG/rxXo3wpLddOFJiAkQH7NC8eNS5QZ9yy1oce68mBrb9+O3NEMh65GA+zq8ObCybwNwosQ5CNHDb1QQYJpagavRQ5yXlFTxJtyoFXonLfZGlWaJVyK/tikbYPwzComVo3P9oSQRm8mqKgwq+FnuKLZJ1M7zcHufJCZpmMaIIPeMnHjn1o3QJdtMY3Hev2g7WIBP9vYSVBH1MQOes8bZCbPfH4ePfbSJZwp7 connor@connor"
}

resource "aws_db_subnet_group" "private" {
  name = "private"
  description = "private"
  subnet_ids = [
	"${aws_subnet.private_us_east_1a.id}",
	"${aws_subnet.private_us_east_1b.id}"
  ]

  tags {
	Name = "private"
  }
}

resource "aws_db_instance" "redash_backend" {
  engine               = "postgres"
  engine_version       = "9.4.5"

  instance_class       = "db.t2.micro"
  storage_type         = "standard"
  allocated_storage    = 5

  name                 = "redash_backend"
  username             = "root"
  password             = "P4$sWord"

  vpc_security_group_ids = [
	"${aws_security_group.postgres.id}"
  ]

  multi_az             = false
  db_subnet_group_name = "${aws_db_subnet_group.private.name}"
  parameter_group_name = "default.postgres9.4"
}

resource "aws_instance" "redash1" {
  ami = "ami-a7ddfbcd"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.public_us_east_1b.id}"
  vpc_security_group_ids = [
	"${aws_security_group.whitelisted_http.id}",
	"${aws_security_group.whitelisted_ssh.id}"
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
  username             = "${var.redash_backend_username}"
  password             = "${var.redash_backend_password}"

  vpc_security_group_ids = [
	"${aws_security_group.internal_postgres.id}"
  ]

  multi_az             = false
  db_subnet_group_name = "${aws_db_subnet_group.private.name}"
  parameter_group_name = "default.postgres9.4"
}

output "redash_url" {
  value = "http://${aws_instance.redash1.public_ip}"
}

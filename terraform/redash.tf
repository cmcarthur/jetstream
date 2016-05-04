resource "aws_instance" "redash1" {
  ami = "ami-aeed0bc3"
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

resource "aws_db_subnet_group" "public" {
  name = "public"
  description = "Subnet group for publicly accessible RDS instances"
  subnet_ids = [
    "${aws_subnet.public_us_east_1a.id}",
    "${aws_subnet.public_us_east_1b.id}"
  ]
  tags {
    Name = "public"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "9.3"
  instance_class       = "db.t2.micro"
  name                 = "redash_backend"
  username             = "${var.redash_backend_username}"
  password             = "${var.redash_backend_password}"
  db_subnet_group_name = "my_database_subnet_group"
  parameter_group_name = "default.postgres9.3"
  vpc_security_group_ids = [
    "${aws_security_group.whitelisted_postgres.id}"
  ]
  publicly_accessible = true
}

resource "aws_key_pair" "master" {
  key_name = "master"
  public_key = "${file(var.public_key_path)}"
}

output "redash_url" {
  value = "http://${aws_instance.redash1.public_ip}"
}

resource "aws_redshift_cluster" "redash" {
  cluster_identifier = "redash"
  node_type = "dc1.large"
  cluster_type = "single-node"

  publicly_accessible = true

  vpc_security_group_ids = [
	"${aws_redshift_security_group.redash.id}"
  ]

  cluster_subnet_group_name = "${aws_redshift_subnet_group.main.name}"
  cluster_parameter_group_name = "${aws_redshift_parameter_group.redash.name}"

  master_username = "root"
  master_password = "password"
  database_name = "redash"
  port = 5439
}

resource "aws_redshift_parameter_group" "redash" {
  name = "redash"
  family = "redshift-1.0"
  description = "Default parameter group"

  parameter {
	name = "require_ssl"
	value = "true"
  }
}

resource "aws_redshift_security_group" "redash" {
  name = "redash"
  description = "Default security group"

  ingress {
	cidr = "${aws_vpc.main.cidr_block}"
  }

  ingress {
	cidr = "68.83.229.62/32" # Connor Home IP
  }
}

resource "aws_redshift_subnet_group" "main" {
  name = "main"
  description = "Main redshift subnet group"

  subnet_ids = [
	"${aws_subnet.public_us_east_1a.id}",
	"${aws_subnet.public_us_east_1b.id}"
  ]
}

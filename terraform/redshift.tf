resource "aws_redshift_cluster" "redash" {
  cluster_identifier = "redash"
  node_type = "dc1.large"
  cluster_type = "single-node"

  publicly_accessible = false

  vpc_security_group_ids = [
	"${aws_security_group.internal_redshift.id}"
  ]

  cluster_subnet_group_name = "${aws_redshift_subnet_group.main.name}"
  cluster_parameter_group_name = "${aws_redshift_parameter_group.redash.name}"

  master_username = "${var.redshift_master_username}"
  master_password = "${var.redshift_master_password}"
  database_name = "${var.redshift_database_name}"
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

resource "aws_redshift_subnet_group" "main" {
  name = "main"
  description = "Main redshift subnet group"

  subnet_ids = [
	"${aws_subnet.private_us_east_1a.id}",
	"${aws_subnet.private_us_east_1b.id}"
  ]
}

output "redshift_database_name" {
  value = "${aws_redshift_cluster.redash.database_name}"
}

output "redshift_host" {
  value = "${aws_redshift_cluster.redash.endpoint}"
}

output "redshift_port" {
  value = "${aws_redshift_cluster.redash.port}"
}

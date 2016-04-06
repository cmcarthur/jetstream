resource "aws_redshift_cluster" "redash" {
  cluster_identifier = "redash"
  node_type = "dc1.large"
  cluster_type = "single-node"

  publicly_accessible = false

  vpc_security_group_ids = [
	"${aws_security_group.redshift.id}"
  ]

  cluster_subnet_group_name = "${aws_redshift_subnet_group.main.name}"
  cluster_parameter_group_name = "${aws_redshift_parameter_group.redash.name}"

  master_username = "root"
  master_password = "P4$sWord"
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

resource "aws_security_group" "redshift" {
  name = "redshift"
  description = "Default security group"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
	from_port = 5439
	to_port = 5439
	protocol = "tcp"
	cidr_blocks = [
	  "${aws_vpc.main.cidr_block}",
	  "68.83.229.62/32", # Connor Home IP
	  "108.16.231.215/32" # Tristan Home IP
	]
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

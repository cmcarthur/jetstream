resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags {
	Name = "public_us_east_1a"
  }
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags {
	Name = "public_us_east_1b"
  }
}


resource "aws_subnet" "private_us_east_1a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags {
	Name = "private_us_east_1a"
  }
}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"

  tags {
	Name = "private_us_east_1b"
  }
}

resource "aws_internet_gateway" "public_us_east_1" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
	Name = "public_us_east_1"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.public_us_east_1.id}"
  }

  tags {
	Name = "main"
  }
}

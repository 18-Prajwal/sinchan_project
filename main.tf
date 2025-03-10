provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAXZEFHZJVB4CM4DUH"
  secret_key = "8gCoHhcZb2v07H3XkSPNHDrhZHcqQREqAeqiaT5L"

}
resource "aws_instance" "example_1" {

  ami           = "ami-03b8adbf322415fd0"
  instance_type = "t2.micro"
  key_name      = "prajwal"
  tags = {
    Name = "worker"
  }
  count           = 2
  security_groups = [aws_security_group.example_sg.name]
  user_data       = ("sample.sh")
}

resource "aws_security_group" "example_sg" {
  tags = {
    Name = "astroids"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_instance" "rakesh" {
  ami = "ami-079b5e5b3971bd10d"
  instance_type = "t2.micro"
  key_name = "rakesh"
  subnet_id = "subnet-0e6efa10d990ee39a"
  vpc_security_group_ids = ["sg-0ebe9ef72de3f2334"]
  user_data = file("${path.module}/app-install.sh")

  tags = {
    Nmae = "rakesh-testing"
  } 
}
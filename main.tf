provider "aws" {
  region     = "us-east-2"
  access_key = "Add_Your_Own_Access_Key"
  secret_key = "Add_Your_Own_secret_key"
}


resource "aws_security_group" "HTTP" {
  name_prefix = "web-server"
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Web_server_server" {
  ami           = "ami-0ddda618e961f2270"
  instance_type = "t2.micro"
  key_name      = "mayor_key.pair"
  count         = 1
  tags          = {
    Name = "Mayor's_server"
  }
 
  user_data     = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              sudo echo "This is our lasr month of DevOps training and we will soon be qualified DevOps enginneers." > /var/www/html/index.html
              EOF
}



# add an index.html file to it
# create a target group
# create an lb

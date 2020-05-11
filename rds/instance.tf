resource "aws_instance" "example" {
  # dynamic AMI for latest version
  ami = data.aws_ami.aws_linux2_lastest.id 
  # the public SSH key(match aws key pair)
  key_name               =  "tom-terraform" 
  instance_type          = "t2.micro"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # the security group
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  connection { # Connect remote EC2
    type        = "ssh"
    host        = self.public_ip # bind public ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }
  provisioner "remote-exec" {      # CLI
    inline = [     # Execute line by line in shell script   # 連接遠端，執行一系列的指令
      "sudo yum install httpd -y", # install httpd
      "sudo service httpd start",  # start
      # 印出字串訊息至index.html 檔
      "echo Welcome to virtual server which is at ${self.public_dns} | sudo tee /var/www/html/index.html", # copy file
    ]
  }
}


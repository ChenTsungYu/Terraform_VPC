resource "aws_security_group" "http_server_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "http_server_sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {               // ingress為入口的限制規則
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "http_server_sg"
  }
}

resource "aws_security_group" "allow_mysqldb" {
  vpc_id = aws_vpc.main.id
  name        = "sg_mysqldb"
  description = "允許mysql連接"
  ingress { // 3306 為mysql defalt port
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.http_server_sg.id]
  }
   /** 
   The protocol : If you select a protocol of "-1" (semantically equivalent to "all", which is not a valid value here),
    you must specify a "from_port" and "to_port" equal to 0. If not icmp, tcp, udp, or "-1" use the protocol number
   */
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self = true // If true, the security group itself will be added as a source to this egress rule.
  }
}

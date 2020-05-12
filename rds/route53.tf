resource "aws_eip" "vpc_eip" {
    vpc = true
    instance   = aws_instance.example.id
    # public_ip = aws_instance.public_ip
    depends_on     = [aws_internet_gateway.main-gw]
}

resource "aws_route53_zone" "route53_zone" {
  name = "alt1.aspmx.l.google.com" # domain
}
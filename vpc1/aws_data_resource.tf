# 修正為動態的AMI(自動更新為最新版本的AMI)
data "aws_ami_ids" "aws_linux2_lastest_ids" { # 加入所有的ami id
  owners = ["amazon"] # 注意資料結構
}
data "aws_ami" "aws_linux2_lastest" {
  most_recent = true
  owners = ["amazon"] # 注意資料結構
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}
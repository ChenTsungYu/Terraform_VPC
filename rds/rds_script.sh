read -p "Please input your password: " psd
echo "Your password is '${psd}'"
echo "start applying"
terraform apply -var RDS_PASSWORD="${psd}"
echo "Done!"

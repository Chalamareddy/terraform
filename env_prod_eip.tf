# Associate EIP to Usermanager1
#resource "aws_eip_association" "prod-usermanager1" {
#  instance_id   = "${aws_instance.prod-usermanager1.id}"
#  allocation_id = "${var.prod-usermanager1-eip}"
#}
# Associate EIP to Usermanager2
#resource "aws_eip_association" "prod-usermanager2" {
#  instance_id   = "${aws_instance.prod-usermanager2.id}"
#  allocation_id = "${var.prod-usermanager2-eip}"
#}
# Associate EIP to VPN NAT
resource "aws_eip_association" "prod-vpnnat1" {
  instance_id   = "${aws_instance.prod-vpnnat1.id}"
  allocation_id = "${var.prod-vpnnat1-eip}"
}
/*# Associate EIP to VPN IPSEC
resource "aws_eip_association" "prod-vpn-ipsec" {
  instance_id   = "${aws_instance.prod-vpnipsec.id}"
  allocation_id = "${var.prod-vpn-ipsec-eip}"
}*/

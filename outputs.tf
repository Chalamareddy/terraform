output "private_subnets_prod" {
  value = ["${aws_subnet.private_prod.*.id}"]
}

output "public_subnets_prod" {
  value = ["${aws_subnet.public_prod.*.id}"]
}

# output "elb_subnets_prod" {
#   value = ["${aws_subnet.elb_prod.*.id}"]
# }

output "vpc_prod_id" {
  value = "${aws_vpc.cwhvpcprod.id}"
}

output "simplead_dns" {
  value = "${aws_directory_service_directory.cwhsimplead.dns_ip_addresses}"
}

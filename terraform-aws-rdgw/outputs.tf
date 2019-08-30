output "rdgw-load-balancer-name" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "LoadBalancerName", "")}"
}

output "rdgw-load-balancer-dns" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "LoadBalancerDns", "")}"
}

output "rdgw-load-balancer-zone-id" {
  value = "${aws_route53_record.this.zone_id}"
}

output "rdgw-alb-security-group-id" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "AlbSecurityGroupId", "")}"
}

output "rdgw-ec2-security-group-id" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "Ec2SecurityGroupId", "")}"
}

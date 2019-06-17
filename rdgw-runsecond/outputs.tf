output "rdgw_loadbalancername" {
 value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "LoadBalancerName", "")}"
}
output "rdgw_LoadBalancerDns" {
 value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "LoadBalancerDns", "")}"
}
output "rdgw_LoadBalancerZoneId" {
 value = "${aws_route53_record.lb_pub_dns.zone_id}"
}
output "rdgw_AlbSecurityGroupId" {
 value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "AlbSecurityGroupId", "")}"
}
output "rdgw_Ec2SecurityGroupId" {
 value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "Ec2SecurityGroupId", "")}"
}
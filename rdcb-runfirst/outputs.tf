#output "URL" {
#  value = "https://${aws_acm_certificate.cert.domain_name}/guacamole"
#}
output "rdcb_snsarn" {
 value = "${lookup(data.aws_cloudformation_stack.rdcb.outputs, "SnsArn", "")}"
}

output "rdcb_instanceip" {
 value = "${lookup(data.aws_cloudformation_stack.rdcb.outputs, "RdcbEc2InstanceIp", "")}"
}

output "rdcb_instanceid" {
 value = "${lookup(data.aws_cloudformation_stack.rdcb.outputs, "RdcbEc2InstanceId", "")}"
}

output "rdcb_sg_id" {
 value = "${aws_security_group.rdcb-sg1.id}"
}
output "rdcb_fqdn" {
value = "${aws_route53_record.private_dns_record.fqdn}"
}

output "rdsh_sg_id" {
 value = "${aws_security_group.rdsh-sg1.id}"
}

output "rdcb_hostname" {
 value = "${format("%s.%s", data.local_file.rdcb_hostname.content, var.DomainDnsName)}"
}
output "rdcb-sns-arn" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "SnsArn", "")}"
}

output "rdcb-instance-ip" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "RdcbEc2InstanceIp", "")}"
}

output "rdcb-instance-id" {
  value = "${lookup(data.aws_cloudformation_stack.this.outputs, "RdcbEc2InstanceId", "")}"
}

output "rdcb-dns-zone-id" {
  value = "${aws_route53_record.this.zone_id}"
}

output "rdcb-sg-id" {
  value = "${aws_security_group.rdcb-sg1.id}"
}

output "rdcb-fqdn" {
  value = "${aws_route53_record.this.fqdn}"
}

output "rdsh-sg-id" {
  value = "${aws_security_group.rdsh-sg1.id}"
}

output "rdcb-hostname" {
  value = "${format("%s.%s", data.local_file.rdcb_hostname.content, var.DomainDnsName)}"
}

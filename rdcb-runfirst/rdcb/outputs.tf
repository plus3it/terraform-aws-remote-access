#output "URL" {
#  value = "https://${aws_acm_certificate.cert.domain_name}/guacamole"
#}
#output "rdcb_snsarn" {
#  value = "${lookup(aws_cloudformation_stack.rdcb.attributes, "outputs.SnsArn", "")}"
#}
#
#output "rdcb_instanceip" {
#  value = "${lookup(aws_cloudformation_stack.rdcb.outputs, "RdcbEc2InstanceIp", "")}"
#}
#
#output "rdcb_instanceid" {
#  value = "${lookup(aws_cloudformation_stack.rdcb.outputs, "RdcbEc2InstanceId", "")}"
#}


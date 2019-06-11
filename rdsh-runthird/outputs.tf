#output "URL" {
#  value = "https://${aws_acm_certificate.cert.domain_name}/guacamole"
#}
# output "rdgw_loadbalancername" {
#  value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "LoadBalancerName", "")}"
# }
# 
# output "rdgw_LoadBalancerDns" {
#  value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "LoadBalancerDns", "")}"
# }
# 
# output "rdgw_AlbSecurityGroupId" {
#  value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "AlbSecurityGroupId", "")}"
# }
# 
# output "rdgw_Ec2SecurityGroupId" {
#  value = "${lookup(data.aws_cloudformation_stack.rdgw.outputs, "Ec2SecurityGroupId", "")}"
# }


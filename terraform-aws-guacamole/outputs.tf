output "GuacAsgDnsName" {
  value = "${aws_cloudformation_stack.this.LoadBalancerDns}"
}

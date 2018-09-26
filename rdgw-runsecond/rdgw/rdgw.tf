data "aws_cloudformation_stack" "rdgw" {
  name = "${var.stackname}"
  depends_on = ["null_resource.push-changeset"]
}
data "aws_elb" "rdgw" {
  name = "${data.aws_cloudformation_stack.rdgw.outputs["LoadBalancerName"]}"
  depends_on = ["data.aws_cloudformation_stack.rdgw"]
}
resource "null_resource" "push-changeset" {
  provisioner "local-exec" {
    command     = "${join(" ", local.create_changeset_command)}"
    working_dir = ".."
  }

  provisioner "local-exec" {
    command = "${join(" ", local.destroy_changeset_command)}"
    when    = "destroy"
  }
}
locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "cfn/ra_rdgw_autoscale_public_lb.template.cfn.json",
    " --stack-name ${var.stackname}",
    " --s3-bucket ${var.s3bucket}",
    " --parameter-overrides AmiId=${var.amiid}",
    "AmiNameSearchString=${var.aminamesearchstring}",
    "DesiredCapacity=${var.desiredcapacity}",
    "DomainDirectoryId=${var.domaindirectoryid}",
    "DomainDnsName=${var.domaindnsname}",
    "DomainNetbiosName=${var.domainnetbiosname}",
    "ForceUpdateToggle=${var.forceupdatetoggle}",
    "InstanceType=${var.InstanceType}",
    "KeyPairName=${var.KeyPairName}",
    "MaxCapacity=${var.maxcapacity}",
    "MinCapacity=${var.mincapacity}",
    "\"PrivateSubnetIDs=${var.privatesubnetids}\"",
    "\"PublicSubnetIDs=${var.publicsubnetids}\"",
    "\"RemoteAccessUserGroup=${var.remoteaccessusergroup}\"",
    "ScaleDownDesiredCapacity=${var.scaledowndesiredcapacity}",
    "\"ScaleDownSchedule=${var.scaledownschedule}\"",
    "\"ScaleUpSchedule=${var.scaleupschedule}\"",
    "SslCertificateName=${var.SslCertificateName}",
    "SslCertificateService=${var.SslCertificateService}",
    "\"UpdateSchedule=${var.UpdateSchedule}\"",
    "VPC=${var.VpcId}",
    "\"CloudWatchAgentUrl=${var.CloudWatchAgentUrl}\"",
    "--capabilities CAPABILITY_IAM",
  ]

  check_stack_progress = [
    "aws cloudformation wait stack-create-complete --stack-name ${var.stackname}",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.stackname}",
  ]
}
resource "aws_route53_record" "lb_pub_dns" {
  zone_id = "${var.public_dnszone_id}"
  name    = "${var.dns_name}"
  type    = "A"
  alias {
    name                   = "${data.aws_elb.rdgw.dns_name}"
    zone_id                = "${data.aws_elb.rdgw.zone_id}"
    evaluate_target_health = true
  }
}
data "aws_cloudformation_stack" "rdgw" {
  name = "${var.stackname}"
  depends_on = ["null_resource.push-changeset"]
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

#resource "null_resource" "check-changeset" {
#  provisioner "local-exec" {
#    command = "${join(" ", local.check_stack_progress)}"
#  }
#
#  triggers = {
#    instance_ids = "${join(",", null_resource.push-changeset.*.id)}"
#  }
#}

locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "cfn/ra_rdgw_autoscale_public_alb.template.cfn.json",
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
    "VPC=${var.VPC}",
    "--capabilities CAPABILITY_IAM",
  ]

  check_stack_progress = [
    "aws cloudformation wait stack-create-complete --stack-name ${var.stackname}",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.stackname}",
  ]
}

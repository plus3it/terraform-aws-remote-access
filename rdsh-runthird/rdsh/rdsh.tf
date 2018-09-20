data "aws_cloudformation_stack" "rdsh" {
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
    "cfn/ra_rdsh_autoscale_internal_elb.template.cfn.json",
    " --stack-name ${var.stackname}",
    " --s3-bucket ${var.s3bucket}",
    " --parameter-overrides AmiId=${var.AmiId}",
    "\"AmiNameSearchString=${var.AmiNameSearchString}\"",
    "\"ConnectionBrokerFqdn=${var.ConnectionBrokerFqdn}\"",
    "\"DesiredCapacity=${var.DesiredCapacity}\"",
    "\"DomainAccessUserGroup=${var.DomainAccessUserGroup}\"",
    "\"DomainDirectoryId=${var.DomainDirectoryId}\"",
    "\"DomainDnsName=${var.DomainDnsName}\"",
    "\"DomainNetbiosName=${var.DomainNetbiosName}\"",
    "\"DomainSvcAccount=${var.DomainSvcAccount}\"",
    "\"DomainSvcPassword=${var.DomainSvcPassword}\"",
    "\"ExtraSecurityGroupIds=${var.ExtraSecurityGroupIds}\"",
    "\"ForceUpdateToggle=${var.ForceUpdateToggle}\"",
    "\"InstanceType=${var.InstanceType}\"",
    "\"KeyPairName=${var.KeyPairName}\"",
    "\"LdapContainerOU=${var.LdapContainerOU}\"",
    "\"MaxCapacity=${var.MaxCapacity}\"",
    "\"MinCapacity=${var.MinCapacity}\"",
    "\"RdpPrivateKeyPassword=${var.RdpPrivateKeyPassword}\"",
    "\"RdpPrivateKeyPfx=${var.RdpPrivateKeyPfx}\"",
    "\"RdpPrivateKeyS3Endpoint=${var.RdpPrivateKeyS3Endpoint}\"",
    "\"ScaleDownDesiredCapacity=${var.ScaleDownDesiredCapacity}\"",
    "\"ScaleDownSchedule=${var.ScaleDownSchedule}\"",
    "\"ScaleUpSchedule=${var.ScaleUpSchedule}\"",
    "\"SubnetIDs=${var.SubnetIDs}\"",
    "\"UserProfileDiskPath=${var.UserProfileDiskPath}\"",
    "\"VPC=${var.VPC}\"",
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

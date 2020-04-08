data "aws_cloudformation_stack" "this" {
  name       = var.StackName
  depends_on = [null_resource.push-changeset]
}

data "aws_region" "current" {
}

resource "null_resource" "push-changeset" {
  provisioner "local-exec" {
    command     = join(" ", local.create_changeset_command)
    working_dir = path.module
  }

  provisioner "local-exec" {
    command = join(" ", local.destroy_changeset_command)
    when    = destroy
  }
}



# https://github.com/terraform-providers/terraform-provider-aws/issues/132#issuecomment-397707776
# since the aws provider does not currently support cfn change sets cfn templates must be applied
# via the aws cli
locals {
  UserProfileDiskPath = format("\\\\%s", join(var.UserProfileDiskPath, "\\"))

  create_changeset_command = [
    "aws cloudformation deploy --template",
    "ra_rdsh_autoscale_internal_lb.template.cfn.yaml",
    " --stack-name ${var.StackName}",
    " --s3-bucket ${var.S3Bucket}",
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
    "\"ExtraSecurityGroupIds=${join(",", var.ExtraSecurityGroupIds)}\"",
    "\"ForceUpdateToggle=${var.ForceUpdateToggle}\"",
    "\"InstanceType=${var.InstanceType}\"",
    "\"KeyPairName=${var.KeyPairName}\"",
    "\"LdapContainerOU=${var.LdapContainerOU}\"",
    "\"MaxCapacity=${var.MaxCapacity}\"",
    "\"MinCapacity=${var.MinCapacity}\"",
    "\"RdpPrivateKeyPassword=${var.RdpPrivateKeyPassword}\"",
    "\"RdpPrivateKeyPfx=${var.RdpPrivateKeyPfx}\"",
    "\"RdpPrivateKeyS3Endpoint=${var.RdpPrivateKeyS3Endpoint}\"",
    "\"RemoteAccessRepoBranchPrefixUrl=${var.RemoteAccessRepoBranchPrefixUrl}\"",
    "\"UtilitiesRepoBranchPrefixUrl=${var.UtilitiesRepoBranchPrefixUrl}\"",
    "\"ScaleDownDesiredCapacity=${var.ScaleDownDesiredCapacity}\"",
    "\"ScaleDownSchedule=${var.ScaleDownSchedule}\"",
    "\"ScaleUpSchedule=${var.ScaleUpSchedule}\"",
    "\"SubnetIDs=${join(",", var.SubnetIDs)}\"",
    "\"UserProfileDiskPath=${local.UserProfileDiskPath}\"",
    "\"VPC=${var.VpcId}\"",
    "\"CloudWatchAgentUrl=${var.CloudWatchAgentUrl}\"",
    "--capabilities CAPABILITY_IAM",
  ]

  check_stack_progress = [
    "aws cloudformation wait stack-create-complete --stack-name ${var.StackName}",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.StackName}",
  ]
}

resource "aws_route53_record" "this" {
  zone_id = var.PrivateDnszoneId
  name    = var.DnsName
  type    = "A"

  alias {
    name                   = data.aws_cloudformation_stack.this.outputs["LoadBalancerDns"]
    zone_id                = var.NlbZones[data.aws_region.current.name]
    evaluate_target_health = true
  }
}


provider "aws" {
  #  use aws profile for iam access keys
  region = "${var.region}"
}

resource "null_resource" "push-changeset" {
  provisioner "local-exec" {
    command = "${join(" ", local.create_changeset_command)}"
  }

  provisioner "local-exec" {
    command = "${join(" ", local.destroy_changeset_command)}"
    when    = "destroy"
  }
}

locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "cfn/ra_rdcb_fileserver_standalone.template.cfn.json",
    " --stack-name ${var.stackname}",
    " --s3-bucket ${var.s3bucket}",
    " --parameter-overrides AmiId=${var.amiid} AmiNameSearchString=${var.aminamesearchstring} DataVolumeSize=${var.datavolumesize} DataVolumeSnapshotid=${var.datavolumesnapshotid} DomainAccessUserGroup=\"${var.domainaccessusergroup}\" DomainDirectoryId=${var.domaindirectoryid} DomainDnsName=${var.domaindnsname} DomainNetbiosName=${var.DomainNetbiosName} Ec2SubnetAz=${var.ec2subnetaz} Ec2SubnetId=${var.Ec2SubnetId} ExtraSecurityGroupIds=${var.ExtraSecurityGroupIds} InstanceType=${var.InstanceType} KeyPairName=${var.KeyPairName} NoPublicIp=${var.NoPublicIp} NotificationEmail=${var.NotificationEmail} SsmKeyId=${var.SsmKeyId} SsmRdcbCredential=${var.SsmRdcbCredential} VpcId=${var.VpcId}",
    "--capabilities CAPABILITY_IAM",
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.stackname}",
  ]
}

#data "template_file" "user_data" {
#  template = "${file("${path.module}/../cfn/ra_rdcb_fileserver_standalone.template.cfn.json")}"
#
#  vars {
#    #    git_repo            = "${var.git_repo}"  #    GUAC_ADMIN_PASSWORD = "${var.GUAC_ADMIN_PASSWORD}"  #    domain_name         = "${var.domain_name}"
#  }
#}


#resource "aws_cloudformation_stack" "rdcb" {
#  name = "${var.stack_name}"
#
#  parameters {
#    amiid = "${var.amiid}"
#
#    aminamesearchstring = "${var.aminamesearchstring}"
#
#    datavolumesize = "${var.datavolumesize}"
#
#    datavolumesnapshotid = "${var.datavolumesnapshotid}"
#
#    domainaccessusergroup = "${var.domainaccessusergroup}"
#
#    domaindirectoryid = "${var.domaindirectoryid}"
#
#    domaindnsname = "${var.domaindnsname}"
#
#    DomainNetbiosName = "${var.DomainNetbiosName}"
#
#    ec2subnetaz = "${var.ec2subnetaz}"
#
#    Ec2SubnetId = "${var.Ec2SubnetId}"
#
#    ExtraSecurityGroupIds = "${var.ExtraSecurityGroupIds}"
#
#    InstanceType = "${var.InstanceType}"
#
#    KeyPairName = "${var.KeyPairName}"
#
#    NoPublicIp = "${var.NoPublicIp}"
#
#    NotificationEmail = "${var.NotificationEmail}"
#
#    SsmKeyId = "${var.SsmKeyId}"
#
#    SsmRdcbCredential = "${var.SsmRdcbCredential}"
#
#    VpcId = "${var.VpcId}"
#  }
#
#  template_body = "${data.template_file.user_data.rendered}"
#
#  #template_url = "https://s3.amazonaws.com/app-chemistry/templates/ra_rdcb_fileserver_standalone.template.json"
#}


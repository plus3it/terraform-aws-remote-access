provider "aws" {
  #  use aws profile for iam access keys
  region = "${var.region}"
}

data "terraform_remote_state" "rdcb" {
  backend = "local"

  config {
    path = "${path.module}/../rdcb-runfirst/terraform.tfstate"
  }
}


module "rdsh" {
  source                   = "./rdsh"
  stackname                = "${var.stackname}"
  s3bucket                 = "${var.s3bucket}"
  AmiId                    = "${var.AmiId}"
  AmiNameSearchString      = "${var.AmiNameSearchString}"
  ConnectionBrokerFqdn     = "${data.terraform_remote_state.rdcb.rdcb_hostname}"
  DesiredCapacity          = "${var.DesiredCapacity}"
  DomainAccessUserGroup    = "${var.DomainAccessUserGroup}"
  DomainDirectoryId        = "${var.DomainDirectoryId}"
  DomainDnsName            = "${var.DomainDnsName}"
  DomainNetbiosName        = "${var.DomainNetbiosName}"
  DomainSvcAccount         = "${var.DomainSvcAccount}"
  DomainSvcPassword        = "${var.DomainSvcPassword}"
  ExtraSecurityGroupIds    = "${var.ExtraSecurityGroupIds}"
  ForceUpdateToggle        = "${var.ForceUpdateToggle}"
  InstanceType             = "${var.InstanceType}"
  KeyPairName              = "${var.KeyPairName}"
  LdapContainerOU          = "${var.LdapContainerOU}"
  MaxCapacity              = "${var.MaxCapacity}"
  MinCapacity              = "${var.MinCapacity}"
  RdpPrivateKeyPassword    = "${var.RdpPrivateKeyPassword}"
  RdpPrivateKeyPfx         = "${var.RdpPrivateKeyPfx}"
  RdpPrivateKeyS3Endpoint  = "${var.RdpPrivateKeyS3Endpoint}"
  ScaleDownDesiredCapacity = "${var.ScaleDownDesiredCapacity}"
  ScaleDownSchedule        = "${var.ScaleDownSchedule}"
  ScaleUpSchedule          = "${var.ScaleUpSchedule}"
  SubnetIDs                = "${var.SubnetIDs}"
  UserProfileDiskPath      = "${var.UserProfileDiskPath}"
  VpcId                    = "${var.VpcId}"
  CloudWatchAgentUrl       = "${var.CloudWatchAgentUrl}"
  private_dnszone_id       = "${var.private_dnszone_id}"
  dns_name                 = "${var.dns_name}"
  rdcb_fqdn                = "${data.terraform_remote_state.rdcb.rdcb_fqdn}"
  rdsh_sg_id               = "${data.terraform_remote_state.rdcb.rdsh_sg_id}"
  }
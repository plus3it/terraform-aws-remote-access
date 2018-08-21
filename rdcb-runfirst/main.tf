provider "aws" {
  #  use aws profile for iam access keys
  region = "${var.region}"
}

module "rdcb" {
  source = "./rdcb"
  amiid  = "${var.amiid}"
  aminamesearchstring = "${var.aminamesearchstring}"
  datavolumesize = "${var.datavolumesize}"
  datavolumesnapshotid = "${var.datavolumesnapshotid}"
  domainaccessusergroup = "${var.domainaccessusergroup}"
  domaindirectoryid = "${var.domaindirectoryid}"
  domaindnsname = "${var.domaindnsname}"
  DomainNetbiosName = "${var.DomainNetbiosName}"
  ec2subnetaz = "${var.ec2subnetaz}"
  Ec2SubnetId = "${var.Ec2SubnetId}"
  ExtraSecurityGroupIds = "${var.ExtraSecurityGroupIds}"
  InstanceType = "${var.InstanceType}"
  KeyPairName = "${var.KeyPairName}"
  NoPublicIp = "${var.NoPublicIp}"
  NotificationEmail = "${var.NotificationEmail}"
  SsmKeyId = "${var.SsmKeyId}"
  SsmRdcbCredential = "${var.SsmRdcbCredential}"
  VpcId = "${var.VpcId}"
  stackname = "${var.stackname}"
  s3bucket = "${var.s3bucket}"
  rdcb_dnszone_id = "${var.rdcb_dnszone_id}"
}
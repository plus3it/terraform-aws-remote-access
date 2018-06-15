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
}

#output "rdcb_snsarn" {
#  value = "${module.rdcb.outputs.rdcb_snsarn}"
#}
#
#output "rdcb_instanceip" {
#  value = "${module.rdcb.outputs.RdcbEc2InstanceIp}"
#}
#
#output "rdcb_instanceid" {
#  value = "${module.rdcb.outputs.RdcbEc2InstanceId}"
#}


provider "aws" {
  #  use aws profile for iam access keys
  region = "${var.region}"
}

module "rdgw" {
  source = "./rdgw"
  amiid  = "${var.amiid}"

  aminamesearchstring = "${var.aminamesearchstring}"

  desiredcapacity = "${var.desiredcapacity}"

  domaindirectoryid = "${var.domaindirectoryid}"

  domaindnsname = "${var.domaindnsname}"

  domainnetbiosname = "${var.domainnetbiosname}"

  forceupdatetoggle = "${var.forceupdatetoggle}"

  InstanceType = "${var.InstanceType}"

  KeyPairName = "${var.KeyPairName}"

  maxcapacity = "${var.maxcapacity}"

  mincapacity = "${var.mincapacity}"

  privatesubnetids = "${var.privatesubnetids}"

  publicsubnetids = "${var.publicsubnetids}"

  remoteaccessusergroup = "${var.remoteaccessusergroup}"

  scaledowndesiredcapacity = "${var.scaledowndesiredcapacity}"

  scaledownschedule = "${var.scaledownschedule}"

  scaleupschedule = "${var.scaleupschedule}"

  SslCertificateName = "${var.SslCertificateName}"

  SslCertificateService = "${var.SslCertificateService}"

  UpdateSchedule = "${var.UpdateSchedule}"

  VPC = "${var.VPC}"

  stackname = "${var.stackname}"

  s3bucket = "${var.s3bucket}"
}

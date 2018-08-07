variable "amiid" {
  default = "ami-0a792a70"
}

variable "aminamesearchstring" {
  default = "Windows_Server-2016-English-Full-Base-*"
}

variable "desiredcapacity" {
  default = "1"
}

variable "domaindirectoryid" {
  default = ""
}

variable "domaindnsname" {
  default = ""
}

variable "domainnetbiosname" {
  default = ""
}

variable "forceupdatetoggle" {
  default = "B"
}

variable "InstanceType" {
  default = "m5.large"
}

variable "KeyPairName" {
  default = ""
}

variable "maxcapacity" {
  default = "3"
}

variable "mincapacity" {
  default = "0"
}

variable "privatesubnetids" {
  default = "subnet-xxxxxxxx,subnet-yyyyyyyy,subnet-zzzzzzzz"
}

variable "publicsubnetids" {
  default = "subnet-xxxxxxxx,subnet-yyyyyyyy,subnet-zzzzzzzz"
}

variable "remoteaccessusergroup" {
  default = "Remote Access User Group"
}

variable "scaledowndesiredcapacity" {
  default = "1"
}

variable "scaledownschedule" {
  default = "0 1 * * *"
}

variable "scaleupschedule" {
  default = "0 10 * * Mon-Fri"
}

variable "SslCertificateName" {
  default = ""
}

variable "SslCertificateService" {
  default = ""
}

variable "UpdateSchedule" {
  default = "cron(30 5 ? * Sun *)"
}

variable "VPC" {
  default = ""
}

variable "stackname" {}

variable "s3bucket" {}

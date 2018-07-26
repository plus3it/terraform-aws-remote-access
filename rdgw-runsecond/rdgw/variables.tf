#variable "region" {}

variable "amiid" {
  default = "ami-0a792a70"
}

variable "aminamesearchstring" {
  default = "Windows_Server-2016-English-Full-Base-*"
}

variable "datavolumesize" {
  default = "50"
}

variable "datavolumesnapshotid" {
  default = ""
}

variable "domainaccessusergroup" {
  default = "yourgroupname"
}

variable "domaindirectoryid" {
  default = "d-xxxxxxxxxx"
}

variable "domaindnsname" {
  default = "ad.example.com"
}

variable "DomainNetbiosName" {
  default = "example"
}

variable "ec2subnetaz" {
  default = "us-east-1a"
}

variable "Ec2SubnetId" {
  default = "subnet-xxxxxxxx"
}

variable "ExtraSecurityGroupIds" {
  default = "sg-xxxxxxxx"
}

variable "InstanceType" {
  default = "t2.medium"
}

variable "KeyPairName" {
  default = "yourkeypair"
}

variable "NoPublicIp" {
  default = "true"
}

variable "NotificationEmail" {
  default = ""
}

variable "SsmKeyId" {
  default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "SsmRdcbCredential" {
  default = "/your-path/rdcb/credential"
}

variable "VpcId" {
  default = "vpc-12345678"
}

variable "stackname" {}

variable "s3bucket" {}

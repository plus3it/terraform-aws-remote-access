variable "stackname" {
  default = "rdsh-stack-test-12345"
}

variable "s3bucket" {
  default = "your_bucket"
}

## rdgw module variables
variable "AmiId" {
  default = ""
}

variable "AmiNameSearchString" {
  default = "Windows_Server-2016-English-Full-Base-*"
}

# RDCB instance.  MUST be the actual computer name of the connection broker, not an alias/cname of any kind
variable "ConnectionBrokerFqdn" {
  default = "hostarecord.example.com"
}

variable "DesiredCapacity" {
  default = "1"
}

variable "DomainAccessUserGroup" {
  default = "AD User Group"
}

variable "DomainDirectoryId" {
  default = ""
}

variable "DomainDnsName" {
  default = "example.com"
}

variable "DomainNetbiosName" {
  default = "EXAMPLE"
}

variable "DomainSvcAccount" {
  default = "svc_account"
}

variable "DomainSvcPassword" {
  default = ""
}

variable "ExtraSecurityGroupIds" {
  default = "sg-xxxxxxxx,sg-yyyyyyyy"
}

variable "ForceUpdateToggle" {
  default = "B"
}

variable "InstanceType" {
  default = "t2.medium"
}

variable "KeyPairName" {
  default = "your_keyname"
}

variable "LdapContainerOU" {
  default = "OU=Remote Access Users,DC=example,DC=com"
}

variable "MaxCapacity" {
  default = "1"
}

variable "MinCapacity" {
  default = "0"
}

variable "RdpPrivateKeyPassword" {
  default = ""
}

variable "RdpPrivateKeyPfx" {
  default = "path/toawskey/your_key.pfx"
}

variable "RdpPrivateKeyS3Endpoint" {
  default = "https://s3.amazonaws.com"
}

variable "ScaleDownDesiredCapacity" {
  default = "1"
}

variable "ScaleDownSchedule" {
  default = "0 0 * * *"
}

variable "ScaleUpSchedule" {
  default = "0 10 * * Mon-Fri"
}

variable "SubnetIDs" {
  default = "subnet-xxxxxxxx,subnet-yyyyyyyy,subnet-zzzzzzzz"
}

# RDCB instance.  Must point to YOUR connection broker, and CAN be an alias

variable "UserProfileDiskPath" {
  default = "\\\\\\home.example.com\\Profile$"
}

variable "VpcId" {
  default = "vpc-xxxxxxxx"
}

variable "CloudWatchAgentUrl" {
  type        = "string"
  description = "(Optional) S3 URL to CloudWatch Agent installer. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip"
  default     = ""
}
# DNS Record vars
variable "private_dnszone_id" {
  default = ""
}
variable "dns_name" {
  default = ""
}
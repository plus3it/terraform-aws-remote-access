variable "AmiId" {
  default = ""
  description = ""
  }
variable "AmiNameSearchString" {
  default = "amzn-ami-hvm-2018.03.*-x86_64-gp2"
  description = ""
  }
variable "BrandText" {
  default = "Remote Access"
  description = ""
  }
variable "CloudWatchAgentUrl" {
  default = "s3://amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"
  description = ""
  }
variable "DesiredCapacity" {
  default = "1"
  description = ""
  }
variable "ForceUpdateToggle" {
  default = "B"
  description = ""
  }
variable "GuacBaseDN" {
  default = "CN=GuacConfigGroups"
  description = ""
  }
variable "GuacamoleVersion" {
  default = "1.0.0"
  description = ""
  }
variable "GuacdVersion" {
  default = "1.0.0"
  description = ""
  }
variable "InstanceType" {
  default = "c5.large"
  description = ""
  }
variable "KeyPairName" {
  default = ""
  description = ""
  }
variable "LdapDN" {
  description = "DC=domain,DC=com"
  }
variable "LdapServer" {
  description = "domain.com"
  }
variable "MaxCapacity" {
  default = "1"
  description = ""
  }
variable "MinCapacity" {
  default = "0"
  description = ""
  }
variable "PrivateSubnetIDs" {
  description = "Comma separated string of subnets"
  }
variable "PublicSubnetIDs" {
  description = "Comma separated string of subnets"
  }
variable "ScaleDownDesiredCapacity" {
  default = "1"
  description = ""
  }
variable "ScaleDownSchedule" {
  default = ""
  description = ""
  }
variable "ScaleUpSchedule" {
  default = ""
  description = ""
  }
variable "SslCertificateName" {
  description = "Name of AWS ACM Certificate"
  }
variable "SslCertificateService" {
  default = "ACM"
  description = ""
  }
variable "URL1" {
  default = "https://accounts.domain.com"
  description = ""
  }
variable "URL2" {
  default = "https://redmine.domain.com"
  description = ""
  }
variable "URLText1" {
  default = "Account Services"
  description = ""
  }
variable "URLText2" {
  default = "Redmine"
  description = ""
  }
variable "UpdateSchedule" {
  default = "cron(0 5 ? * Sun *)"
  description = ""
  }
variable "VPC" {
  description = "AWS VPC"
  }

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
}

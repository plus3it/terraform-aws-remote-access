variable "AmiId" {
  default     = ""
  description = ""
  type = "string"
}

variable "AmiNameSearchString" {
  default     = "amzn-ami-hvm-2018.03.*-x86_64-gp2"
  description = ""
  type = "string"
}

variable "BrandText" {
  default     = "Remote Access"
  description = ""
  type = "string"
}

variable "CloudWatchAgentUrl" {
  default     = "s3://amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"
  description = ""
  type = "string"
}

variable "DesiredCapacity" {
  default     = "1"
  description = ""
  type = "string"
}

variable "ForceUpdateToggle" {
  default     = "B"
  description = ""
  type = "string"
}

variable "GuacBaseDN" {
  default     = "CN=GuacConfigGroups"
  description = ""
  type = "string"
}

variable "GuacamoleVersion" {
  default     = "1.0.0"
  description = ""
  type = "string"
}

variable "GuacdVersion" {
  default     = "1.0.0"
  description = ""
  type = "string"
}

variable "InstanceType" {
  default     = "c5.large"
  description = ""
  type = "string"
}

variable "KeyPairName" {
  default     = ""
  description = ""
  type = "string"
}

variable "LdapDN" {
  description = "DC=domain,DC=com"
  type = "string"
}

variable "LdapServer" {
  description = "domain.com"
  type = "string"
}

variable "MaxCapacity" {
  default     = "1"
  description = ""
  type = "string"
}

variable "MinCapacity" {
  default     = "0"
  description = ""
  type = "string"
}

variable "PrivateSubnetIDs" {
  description = "List of private subnets"
  type = "list"
}

variable "PublicSubnetIDs" {
  description = "List of public subnets"
  type = "list"
}

variable "ScaleDownDesiredCapacity" {
  default     = "1"
  description = ""
  type = "string"
}

variable "ScaleDownSchedule" {
  default     = ""
  description = ""
  type = "string"
}

variable "ScaleUpSchedule" {
  default     = ""
  description = ""
  type = "string"
}

variable "SslCertificateName" {
  description = "Name of AWS ACM Certificate"
  type = "string"
}

variable "SslCertificateService" {
  default     = "ACM"
  description = ""
  type = "string"
}

variable "URL1" {
  default     = "https://accounts.domain.com"
  description = ""
  type = "string"
}

variable "URL2" {
  default     = "https://redmine.domain.com"
  description = ""
  type = "string"
}

variable "URLText1" {
  default     = "Account Services"
  description = ""
  type = "string"
}

variable "URLText2" {
  default     = "Redmine"
  description = ""
  type = "string"
}

variable "UpdateSchedule" {
  default     = "cron(0 5 ? * Sun *)"
  description = ""
  type = "string"
}

variable "VPC" {
  description = "AWS VPC"
  type = "string"
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
  type = "string"
}

variable "Capabilities" {
  default     = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_NAMED_IAM", "CAPABILITY_IAM"]
  description = "Required IAM capabilities"
  type        = "list"
}

variable "PolicyBody" {
  type        = "string"
  description = "String containing the stack policy body. Conflicts with PolicyUrl"
  default     = ""
}

variable "PolicyUrl" {
  type        = "string"
  description = "URL to a file containing the stack policy. Conflicts with PolicyBody"
  default     = ""
}

variable "StackTags" {
  type        = "map"
  description = "A map of tag keys/values to associate with this stack"
  default     = {}
}

variable "TimeoutInMinutes" {
  type        = "string"
  description = "The amount of time that can pass before the stack status becomes CREATE_FAILED"
  default     = "20"
}

variable "DisableRollback" {
  type        = "string"
  description = "Set to true to disable rollback of the stack if stack creation failed. Conflicts with OnFailure"
  default     = false
}

variable "IamRoleArn" {
  type        = "string"
  description = "The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials"
  default     = ""
}

variable "NotificationArns" {
  type        = "list"
  description = "A list of SNS topic ARNs to publish stack related events"
  default     = []
}

variable "OnFailureAction" {
  type        = "string"
  description = "Action to be taken if stack creation fails. This must be one of: DO_NOTHING, ROLLBACK, or DELETE. Conflicts with DisableRollback"
  default     = "ROLLBACK"
}

variable "GuacDnsZoneId" {
  type        = "string"
  description = "Id of DNS zone for Guac Load Balancer DNS Record"
}

variable GuacPublicDnsHostname {
  type        = "string"
  description = "Hostname of DNS record used to reach Guac Elb"
  default     = "guacamole"
}

variable "ElbZones" {
  type = "map"

  default = {
    us-east-1 = "Z35SXDOTRQ7X7K"
    us-east-2 = "Z3AADJGX6KTTL2"
    us-west-1 = "Z368ELLRRE2KJ0"
    us-west-2 = "Z1H1FL5HABSF5"
  }
}

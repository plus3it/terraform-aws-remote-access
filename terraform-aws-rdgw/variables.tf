variable "AmiId" {
  default     = ""
  description = "(Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString"
  type        = "string"
}

variable "AmiNameSearchString" {
  default     = "Windows_Server-2016-English-Full-Base-*"
  description = "Search pattern to match against an AMI Name"
  type        = "string"
}

variable "AuthenticationMethod" {
  default     = "Password"
  description = "Configures the RDGW for either Password or Smartcard authentication"
  type        = "string"
}

variable "CloudWatchAgentUrl" {
  type        = "string"
  description = "(Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  default     = ""
}

variable "DesiredCapacity" {
  default     = "1"
  description = "The number of instances the autoscale group will spin up initially"
  type        = "string"
}

variable "DomainDirectoryId" {
  description = "ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx"
  type        = "string"
}

variable "DomainDnsName" {
  default     = "example.com"
  description = "Fully qualified domain name (FQDN) of the forest root domain e.g. example.com"
  type        = "string"
}

variable "DomainNetbiosName" {
  default     = "EXAMPLE"
  description = "NetBIOS name of the domain (e.g. EXAMPLE)"
  type        = "string"
}

variable "ForceUpdateToggle" {
  default     = "A"
  description = "A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy"
  type        = "string"
}

variable "InstanceType" {
  default     = "t2.micro"
  description = "Amazon EC2 instance type for the Remote Desktop Gateway Instance"
  type        = "string"
}

variable "KeyPairName" {
  default     = ""
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
  type        = "string"
}

variable "MaxCapacity" {
  default     = "2"
  description = "The maximum number of instances for the autoscale group"
  type        = "string"
}

variable "MinCapacity" {
  default     = "0"
  description = "The minimum number of instances for the autoscale group"
  type        = "string"
}

variable "PrivateSubnetIds" {
  description = "Comma separated string of Private Subnet IDs where the RDGW instances will run"
  type        = "string"
}

variable "PublicSubnetIds" {
  description = "Comma separated string of Public subnet IDs to attach to the load balancer"
  type        = "string"
}

variable "RemoteAccessUserGroup" {
  default     = "Domain Admins"
  description = "Domain group of users authorized to use the RDGW"
  type        = "string"
}

variable "RepoBranchPrefixUrl" {
  default     = "https://raw.githubusercontent.com/plus3it/cfn/master"
  description = "URL prefix where the repo scripts can be retrieved"
  type        = "string"
}

variable "ScaleDownDesiredCapacity" {
  default     = "1"
  description = "(Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset"
  type        = "string"
}

variable "ScaleDownSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. \"0 0 * * *\")"
  type        = "string"
}

variable "ScaleUpSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. \"0 10 * * Mon-Fri\")"
  type        = "string"
}

variable "SslCertificateName" {
  default     = ""
  description = "The name (for IAM) or identifier (for ACM) of the SSL certificate to associate with the LB -- the cert must already exist in the service"
  type        = "string"
}

variable "SslCertificateService" {
  default     = "ACM"
  description = "The service hosting the SSL certificate.  ACM or IAM are allowed values"
  type        = "string"
}

variable "UpdateSchedule" {
  default     = ""
  description = "(Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  type        = "string"
}

variable "VpcId" {
  default     = "vpc-12345678"
  description = "VPC to deploy instance into"
  type        = "string"
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
  type        = "string"
}

variable "S3Bucket" {}

# DNS record
variable "DnsName" {
  default     = ""
  description = "Hostname of A record created"
  type        = "string"
}

variable "PublicDnszoneId" {
  default     = ""
  description = "Public DNS Zone where the RDGW record will be created"
  type        = "string"
}

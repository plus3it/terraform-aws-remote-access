## rdsh module variables
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

variable "CloudWatchAgentUrl" {
  type        = "string"
  description = "(Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  default     = ""
}

# RDCB instance.  MUST be the actual computer name of the connection broker, not an alias/cname of any kind
variable "ConnectionBrokerFqdn" {
  default = ""
  description = "Fully qualified domain name (FQDN) of the primary Connection Broker, e.g. 'cb.example.com'"
  type        = "string"
}

variable "DesiredCapacity" {
  default     = "1"
  description = "The number of instances the autoscale group will spin up initially"
  type        = "string"
}

variable "DomainAccessUserGroup" {
  default     = "Domain Users"
  description = "Domain group of users authorized to use the RDSH"
  type        = "string"
}

variable "DomainDirectoryId" {
  default     = ""
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
  description = "Netbios name of the domain (e.g. EXAMPLE)"
  type        = "string"
}

variable "DomainSvcAccount" {
  description = "User name for the account that will join the instance to the Connection Broker Cluster"
  type        = "string"
}

variable "DomainSvcPassword" {
  description = "Password for the Connection Broker service account. Must be at least 8 characters containing letters, numbers and symbols"
  type        = "string"
}

variable "ExtraSecurityGroupIds" {
  default     = []
  description = "Comma separated string of extra Security Group IDs to attach to the RDSH instances -- include _at least_ the SG allowing connectivity to the Connection Broker database"
  type        = "list"
}

variable "ForceUpdateToggle" {
  default     = "A"
  description = "A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy"
  type        = "string"
}

variable "InstanceType" {
  default     = "t2.medium"
  description = "Amazon EC2 instance type for the Remote Desktop Session Instance"
  type        = "string"
}

variable "KeyPairName" {
  default = ""
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
  type        = "string"
}

variable "LdapContainerOU" {
  default     = "OU=Users,DC=example,DC=com"
  description = "DN of the LDAP container or OU in which the RDSH instance will be placed"
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

variable "RdpPrivateKeyPassword" {
  description = "Password to the RDP certificate private key"
  type        = "string"
}

variable "RdpPrivateKeyPfx" {
  description = "S3 bucket and path to a private key for the RDP certificate, e.g. '<bucket>/path/to/key.pfx'"
  type        = "string"
}

variable "RdpPrivateKeyS3Endpoint" {
  default     = "https://s3.amazonaws.com"
  description = "S3 endpoint URL hosting the bucket where the RDP certificate private key is stored"
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
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 * * *')"
  type        = "string"
}

variable "ScaleUpSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 * * Mon-Fri')"
  type        = "string"
}

variable "SubnetIDs" {
  default     = []
  description = "List of Subnet IDs where the RDSH instances and ELB will be launched"
  type        = "list"
}

variable "UpdateSchedule" {
  default     = ""
  description = "(Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  type        = "string"
}

# RDCB instance.  Must point to YOUR connection broker, and CAN be an alias
variable "UserProfileDiskPath" {
  default     = "\\\\\\home.example.com\\Profile$"
  description = "Path to a CIFS share where User Profile Disks are stored, e.g. \"\\\\home.example.com\\Profiles$\""
  type        = "string"
}

variable "VpcId" {
  description = "VPC to deploy instance(s) into"
  type        = "string"
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
  type        = "string"
}

variable "S3Bucket" {
  default = "your_bucket"
}

# DNS Record vars
variable "PrivateDnszoneId" {
  default = ""
  description = "ZoneId where DNS record will be created for the RDSH nodes"
  type        = "string"
}

variable "DnsName" {
  default = ""
  description = "Name of Host A DNS Record"
  type        = "string"
}

variable "NlbZones" {
  type = "map"

  default = {
    us-east-1 = "Z26RNL4JYFTOTI"
    us-east-2 = "ZLMOA37VPKANP"
    us-west-1 = "Z24FKFUX50B4VW"
    us-west-2 = "Z18D5FSROUN65G"
  }
}

## rdsh module variables
variable "AmiId" {
  default     = ""
  description = "(Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString"
}

variable "AmiNameSearchString" {
  default     = "Windows_Server-2016-English-Full-Base-*"
  description = "Search pattern to match against an AMI Name"
}

variable "CloudWatchAgentUrl" {
  type        = "string"
  description = "(Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  default     = ""
}

# RDCB instance.  MUST be the actual computer name of the connection broker, not an alias/cname of any kind
variable "ConnectionBrokerFqdn" {
  default     = "cb.example.com"
  description = "Fully qualified domain name (FQDN) of the primary Connection Broker, e.g. 'cb.example.com'"
}

variable "DesiredCapacity" {
  default     = "1"
  description = "The number of instances the autoscale group will spin up initially"
}

variable "DomainAccessUserGroup" {
  default     = "Domain Users"
  description = "Domain group of users authorized to use the RDSH"
}

variable "DomainDirectoryId" {
  default     = ""
  description = "ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx"
}

variable "DomainDnsName" {
  default     = "example.com"
  description = "Fully qualified domain name (FQDN) of the forest root domain e.g. example.com"
}

variable "DomainNetbiosName" {
  default     = "EXAMPLE"
  description = "Netbios name of the domain (e.g. EXAMPLE)"
}

variable "DomainSvcAccount" {
  default     = "CbSvcAccount"
  description = "User name for the account that will join the instance to the Connection Broker Cluster"
}

variable "DomainSvcPassword" {
  default     = "Password123"
  description = "Password for the Connection Broker service account. Must be at least 8 characters containing letters, numbers and symbols"
}

variable "ExtraSecurityGroupIds" {
  default     = ""
  description = "Comma separated string of extra Security Group IDs to attach to the RDSH instances -- include _at least_ the SG allowing connectivity to the Connection Broker database"
  type = "string"
}

variable "ForceUpdateToggle" {
  default     = "A"
  description = "A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy"
}

variable "InstanceType" {
  default     = "t2.medium"
  description = "Amazon EC2 instance type for the Remote Desktop Session Instance"
}

variable "KeyPairName" {
  default     = "your_keyname"
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
}

variable "LdapContainerOU" {
  default     = "OU=Users,DC=example,DC=com"
  description = "DN of the LDAP container or OU in which the RDSH instance will be placed"
}

variable "MaxCapacity" {
  default     = "2"
  description = "The maximum number of instances for the autoscale group"
}

variable "MinCapacity" {
  default     = "0"
  description = "The minimum number of instances for the autoscale group"
}

variable "RdpPrivateKeyPassword" {
  description = "Password to the RDP certificate private key"
}

variable "RdpPrivateKeyPfx" {
  default     = "path/toawskey/your_key.pfx"
  description = "S3 bucket and path to a private key for the RDP certificate, e.g. '<bucket>/path/to/key.pfx'"
}

variable "RdpPrivateKeyS3Endpoint" {
  default     = "https://s3.amazonaws.com"
  description = "S3 endpoint URL hosting the bucket where the RDP certificate private key is stored"
}

variable "ScaleDownDesiredCapacity" {
  default     = "1"
  description = "(Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset"
}

variable "ScaleDownSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 * * *')"
}

variable "ScaleUpSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 * * Mon-Fri')"
}

variable "SubnetIDs" {
  default     = "subnet-xxxxxxxx,subnet-yyyyyyyy,subnet-zzzzzzzz"
  description = "Commad separated string of Subnet IDs where the RDSH instances and ELB will be launched"
}

variable "UpdateSchedule" {
  default     = ""
  description = "(Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
}

# RDCB instance.  Must point to YOUR connection broker, and CAN be an alias
variable "UserProfileDiskPath" {
  default     = "\\\\\\home.example.com\\Profile$"
  description = "Path to a CIFS share where User Profile Disks are stored, e.g. \"\\\\home.example.com\\Profiles$\""
}

variable "VpcId" {
  default     = "vpc-12345678"
  description = "VPC to deploy instance(s) into"
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
}

variable "S3Bucket" {
  default = "your_bucket"
}

# DNS Record vars
variable "Private_Dnszone_Id" {
  default = ""
}

variable "Dns_Name" {
  default = ""
}

variable "nlb_zones" {
  type = "map"

  default = {
    us-east-1 = "Z26RNL4JYFTOTI"
    us-east-2 = "ZLMOA37VPKANP"
    us-west-1 = "Z24FKFUX50B4VW"
    us-west-2 = "Z18D5FSROUN65G"
  }
}

#remote_state inputs
variable "Rdsh_Sg_Id" {
  default = ""
}

variable "Rdcb_Fqdn" {
  default = ""
}

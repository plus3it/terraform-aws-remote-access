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
  description = "(Optional) S3 URL to CloudWatch Agent installer. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  default     = ""
}

variable "DataVolumeSize" {
  default     = "50"
  description = "Size of the data volume to attach to the instance"
}

variable "DataVolumeSnapshotId" {
  default     = ""
  description = "(Optional) Snapshot ID of an existing EBS volume. Leave blank to instantiate an empty volume"
}

variable "DomainAccessUserGroup" {
  default     = "yourgroupname"
  description = "Domain group of users authorized to use the remote access solution"
}

variable "DomainDirectoryId" {
  default     = "d-xxxxxxxxxx"
  description = "ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx"
}

variable "DomainDnsName" {
  default     = "ad.example.com"
  description = "Fully qualified domain name (FQDN) of the forest root domain, e.g. example.com"
}

variable "DomainNetbiosName" {
  default     = "example"
  description = "NetBIOS name of the domain (e.g. EXAMPLE)"
}

variable "Ec2SubnetAz" {
  default     = "us-east-1a"
  description = "Availability zone of the private subnet"
}

variable "Ec2SubnetId" {
  default     = "subnet-xxxxxxxx"
  description = "Private Subnet ID where the file server will run"
}

variable "ExtraSecurityGroupIds" {
  default     = ""
  description = "List of extra Security Group IDs to attach to the RDCB EC2 instance"
}

variable "InstanceType" {
  default     = "t2.medium"
  description = "Amazon EC2 instance type for the Remote Desktop Session Instance"
}

variable "KeyPairName" {
  default     = "yourkeypair"
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
}

variable "NoPublicIp" {
  default     = "true"
  description = "Controls whether to assign the instances a public IP. Recommended to leave at 'true' _unless_ launching in a public subnet"
}

variable "NotificationEmail" {
  default     = ""
  description = "(Optional) Email address to subscribe to notifications and alarms"
}

variable "SsmKeyId" {
  default     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  description = "KMS Key ID used to encrypt/decrypt the SsmRdcbCredential"
}

variable "SsmRdcbCredential" {
  default     = "/your-path/rdcb/credential"
  description = "SSM Parameter Name for a SecureString containing the domain credential for the RDCB service account. SSM Parameter Value format is '@{Username = \"<user>\"; Password = \"<password>\"}'"
}

variable "VpcId" {
  default     = "vpc-12345678"
  description = "VPC to deploy instance into"
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
}

variable "SecurityGroupIngress" {
  default = []
  description = "List of security group IPs to allow"
  type = "list"
}

variable "S3Bucket" {}

variable "RdcbDnszoneId" {
  default     = ""
  description = "Zone to create DNS record for RDCB instance"
}

variable "AmiId" {
  default     = ""
  description = "(Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString"
  type        = string
}

variable "AmiNameSearchString" {
  default     = "amzn-ami-hvm-2018.03.*-x86_64-gp2"
  description = "Search pattern to match against an AMI Name"
  type        = string
}

variable "BrandText" {
  default     = "Remote Access"
  description = "Text/Label to display branding for the Guac Login page"
  type        = string
}

variable "CloudWatchAgentUrl" {
  default     = "s3://amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"
  description = "(Optional) S3 URL to CloudWatch Agent installer. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
  type        = string
}

variable "DesiredCapacity" {
  default     = "1"
  description = "The number of instances the autoscale group will spin up initially"
  type        = string
}

variable "ForceUpdateToggle" {
  default     = "B"
  description = "A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy"
  type        = string
}

variable "GuacBaseDN" {
  default     = "CN=GuacConfigGroups"
  description = "The base of the DN for all Guacamole configurations."
  type        = string
}

variable "GuacamoleVersion" {
  default     = "1.0.0"
  description = "Guacamole version tag. Defaults to 1.0.0"
  type        = string
}

variable "GuacdVersion" {
  default     = "1.0.0"
  description = "Guacd version tag. Defaults to 1.0.0"
  type        = string
}

variable "InstanceType" {
  default     = "c5.large"
  description = "Amazon EC2 instance type for the Remote Desktop Session Instance"
  type        = string
}

variable "KeyPairName" {
  default     = ""
  description = "Public/private key pairs allow you to securely connect to your instance after it launches"
  type        = string
}

variable "LdapDN" {
  description = "Distinguished Name (DN) of the LDAP directory.  E.g. DC=domain,DC=com"
  type        = string
}

variable "LdapServer" {
  description = "Name of LDAP server Guacamole will authenticate against.  E.g. domain.com"
  type        = string
}

variable "MaxCapacity" {
  default     = "1"
  description = "The maximum number of instances for the autoscale group"
  type        = string
}

variable "MinCapacity" {
  default     = "0"
  description = "The minimum number of instances for the autoscale group"
  type        = string
}

variable "PrivateSubnetIDs" {
  description = "List of Private Subnet IDs where the Guacamole instances will run"
  type        = list(string)
}

variable "PublicSubnetIDs" {
  description = "List of Public subnet IDs to attach to the Application Load Balancer"
  type        = list(string)
}

variable "ScaleDownDesiredCapacity" {
  default     = "1"
  description = "(Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset"
  type        = string
}

variable "ScaleDownSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 * * *')"
  type        = string
}

variable "ScaleUpSchedule" {
  default     = ""
  description = "(Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 * * Mon-Fri')"
  type        = string
}

variable "SslCertificateName" {
  description = "The name (for IAM) or identifier (for ACM) of the SSL certificate to associate with the ALB -- the cert must already exist in the service"
  type        = string
}

variable "SslCertificateService" {
  default     = "ACM"
  description = "The service hosting the SSL certificate"
  type        = string
}

variable "URL1" {
  default     = "https://accounts.domain.com"
  description = "First custom URL/link to display on the Guac Login page"
  type        = string
}

variable "URL2" {
  default     = "https://redmine.domain.com"
  description = "Second custom URL/link to display on the Guac Login page"
  type        = string
}

variable "URLText1" {
  default     = "Account Services"
  description = "Text/Label to display for the First custom URL/link displayed on the Guac Login page"
  type        = string
}

variable "URLText2" {
  default     = "Redmine"
  description = "Text/Label to display for the Second custom URL/link displayed on the Guac Login page"
  type        = string
}

variable "UpdateSchedule" {
  default     = "cron(0 5 ? * Sun *)"
  description = "(Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  type        = string
}

variable "Vpc" {
  description = "VPC to deploy instance(s) into"
  type        = string
}

variable "StackName" {
  description = "CloudFormation Stack Name.  Must be less than 10 characters"
  type        = string
}

variable "Capabilities" {
  default     = ["CAPABILITY_AUTO_EXPAND", "CAPABILITY_NAMED_IAM", "CAPABILITY_IAM"]
  description = "Required IAM capabilities"
  type        = list(string)
}

variable "PolicyBody" {
  default     = ""
  description = "String containing the stack policy body. Conflicts with PolicyUrl"
  type        = string
}

variable "PolicyUrl" {
  default     = ""
  description = "URL to a file containing the stack policy. Conflicts with PolicyBody"
  type        = string
}

variable "StackTags" {
  default     = {}
  description = "A map of tag keys/values to associate with this stack"
  type        = map(string)
}

variable "TimeoutInMinutes" {
  default     = "20"
  description = "The amount of time that can pass before the stack status becomes CREATE_FAILED"
  type        = string
}

variable "DisableRollback" {
  default     = false
  description = "Set to true to disable rollback of the stack if stack creation failed. Conflicts with OnFailure"
  type        = string
}

variable "IamRoleArn" {
  default     = ""
  description = "The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials"
  type        = string
}

variable "NotificationArns" {
  default     = []
  description = "A list of SNS topic ARNs to publish stack related events"
  type        = list(string)
}

variable "OnFailureAction" {
  default     = "ROLLBACK"
  description = "Action to be taken if stack creation fails. This must be one of: DO_NOTHING, ROLLBACK, or DELETE. Conflicts with DisableRollback"
  type        = string
}

variable "GuacDnsZoneId" {
  description = "Id of DNS zone for Guac Load Balancer DNS Record"
  type        = string
}

variable "GuacPublicDnsHostname" {
  default     = "guacamole"
  description = "Hostname of DNS record used to reach Guac Elb"
  type        = string
}

variable "ElbZones" {
  description = "Map of ELB Zones"
  type        = map(string)

  default = {
    us-east-1 = "Z35SXDOTRQ7X7K"
    us-east-2 = "Z3AADJGX6KTTL2"
    us-west-1 = "Z368ELLRRE2KJ0"
    us-west-2 = "Z1H1FL5HABSF5"
  }
}


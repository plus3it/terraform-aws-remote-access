## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| AmiId | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | string | `""` | no |
| AmiNameSearchString | Search pattern to match against an AMI Name | string | `"Windows_Server-2016-English-Full-Base-*"` | no |
| CloudWatchAgentUrl | (Optional) S3 URL to CloudWatch Agent installer. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | string | `""` | no |
| DataVolumeSize | Size of the data volume to attach to the instance | string | `"50"` | no |
| DataVolumeSnapshotId | (Optional) Snapshot ID of an existing EBS volume. Leave blank to instantiate an empty volume | string | `""` | no |
| DomainAccessUserGroup | Domain group of users authorized to use the remote access solution | string | `"yourgroupname"` | no |
| DomainDirectoryId | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | string | `"d-xxxxxxxxxx"` | no |
| DomainDnsName | Fully qualified domain name (FQDN) of the forest root domain, e.g. example.com | string | `"ad.example.com"` | no |
| DomainNetbiosName | NetBIOS name of the domain (e.g. EXAMPLE) | string | `"example"` | no |
| Ec2SubnetAz | Availability zone of the private subnet | string | `"us-east-1a"` | no |
| Ec2SubnetId | Private Subnet ID where the file server will run | string | `"subnet-xxxxxxxx"` | no |
| ExtraSecurityGroupIds | List of extra Security Group IDs to attach to the RDCB EC2 instance | string | `"sg-xxxxxxxx"` | no |
| InstanceType | Amazon EC2 instance type for the Remote Desktop Session Instance | string | `"t2.medium"` | no |
| KeyPairName | Public/private key pairs allow you to securely connect to your instance after it launches | string | `"yourkeypair"` | no |
| NoPublicIp | Controls whether to assign the instances a public IP. Recommended to leave at 'true' _unless_ launching in a public subnet | string | `"true"` | no |
| NotificationEmail | (Optional) Email address to subscribe to notifications and alarms | string | `""` | no |
| Rdcb\_Dnszone\_Id | Zone to create DNS record for RDCB instance | string | `""` | no |
| S3Bucket |  | string | n/a | yes |
| SsmKeyId | KMS Key ID used to encrypt/decrypt the SsmRdcbCredential | string | `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` | no |
| SsmRdcbCredential | SSM Parameter Name for a SecureString containing the domain credential for the RDCB service account. SSM Parameter Value format is '@{Username = "<user>"; Password = "<password>"}' | string | `"/your-path/rdcb/credential"` | no |
| StackName | CloudFormation Stack Name.  Must be less than 10 characters | string | n/a | yes |
| VpcId | VPC to deploy instance into | string | `"vpc-12345678"` | no |

## Outputs

| Name | Description |
|------|-------------|
| rdcb\_dns\_zone\_id |  |
| rdcb\_fqdn |  |
| rdcb\_hostname |  |
| rdcb\_instanceid |  |
| rdcb\_instanceip |  |
| rdcb\_sg\_id |  |
| rdcb\_snsarn | output "URL" {value = "https://${aws_acm_certificate.cert.domain_name}/guacamole"} |
| rdsh\_sg\_id |  |
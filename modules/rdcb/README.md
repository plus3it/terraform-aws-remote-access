# rdcb

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudformation_stack) | data source |
| [local_file.rdcb_hostname](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AmiLookupLambdaArn"></a> [AmiLookupLambdaArn](#input\_AmiLookupLambdaArn) | Arn of the ami-lookup-id lambda. See https://github.com/plus3it/lookup-ami-ids for more details. | `string` | n/a | yes |
| <a name="input_S3Bucket"></a> [S3Bucket](#input\_S3Bucket) | n/a | `any` | n/a | yes |
| <a name="input_StackName"></a> [StackName](#input\_StackName) | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| <a name="input_VpcId"></a> [VpcId](#input\_VpcId) | VPC to deploy instance into | `string` | n/a | yes |
| <a name="input_AmiFilters"></a> [AmiFilters](#input\_AmiFilters) | List of maps with additional ami search filters | <pre>list(object(<br>    {<br>      Name   = string,<br>      Values = list(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "Name": "name",<br>    "Values": [<br>      "Windows_Server-2016-English-Full-Base-*"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_AmiId"></a> [AmiId](#input\_AmiId) | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| <a name="input_AmiOwners"></a> [AmiOwners](#input\_AmiOwners) | List of owners to filter ami search results against | `list(string)` | <pre>[<br>  "amazon"<br>]</pre> | no |
| <a name="input_CloudWatchAgentUrl"></a> [CloudWatchAgentUrl](#input\_CloudWatchAgentUrl) | (Optional) HTTPS URL to CloudWatch Agent installer. Example: https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| <a name="input_DataVolumeSize"></a> [DataVolumeSize](#input\_DataVolumeSize) | Size of the data volume to attach to the instance | `string` | `"50"` | no |
| <a name="input_DataVolumeSnapshotId"></a> [DataVolumeSnapshotId](#input\_DataVolumeSnapshotId) | (Optional) Snapshot ID of an existing EBS volume. Leave blank to instantiate an empty volume | `string` | `""` | no |
| <a name="input_DomainAccessUserGroup"></a> [DomainAccessUserGroup](#input\_DomainAccessUserGroup) | Domain group of users authorized to use the remote access solution | `string` | `"yourgroupname"` | no |
| <a name="input_DomainDirectoryId"></a> [DomainDirectoryId](#input\_DomainDirectoryId) | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | `"d-xxxxxxxxxx"` | no |
| <a name="input_DomainDnsName"></a> [DomainDnsName](#input\_DomainDnsName) | Fully qualified domain name (FQDN) of the forest root domain, e.g. example.com | `string` | `"ad.example.com"` | no |
| <a name="input_DomainNetbiosName"></a> [DomainNetbiosName](#input\_DomainNetbiosName) | NetBIOS name of the domain (e.g. EXAMPLE) | `string` | `"example"` | no |
| <a name="input_DomainOuDn"></a> [DomainOuDn](#input\_DomainOuDn) | DN of the Organizational Unit (OU) for the RDCB computer object (e.g. OU=test,DC=example,DC=com) | `string` | `"DC=example,DC=com"` | no |
| <a name="input_Ec2SubnetAz"></a> [Ec2SubnetAz](#input\_Ec2SubnetAz) | Availability zone of the private subnet | `string` | `"us-east-1a"` | no |
| <a name="input_Ec2SubnetId"></a> [Ec2SubnetId](#input\_Ec2SubnetId) | Private Subnet ID where the file server will run | `string` | `"subnet-xxxxxxxx"` | no |
| <a name="input_ExtraSecurityGroupIds"></a> [ExtraSecurityGroupIds](#input\_ExtraSecurityGroupIds) | List of extra Security Group IDs to attach to the RDCB EC2 instance | `list(string)` | `[]` | no |
| <a name="input_ForceCfnInitUpdate"></a> [ForceCfnInitUpdate](#input\_ForceCfnInitUpdate) | Toggles a cfn-init metadata update even if nothing else changes | `string` | `"A"` | no |
| <a name="input_InstanceType"></a> [InstanceType](#input\_InstanceType) | Amazon EC2 instance type for the Remote Desktop Session Instance | `string` | `"t2.medium"` | no |
| <a name="input_KeyPairName"></a> [KeyPairName](#input\_KeyPairName) | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `"yourkeypair"` | no |
| <a name="input_NoPublicIp"></a> [NoPublicIp](#input\_NoPublicIp) | Controls whether to assign the instances a public IP. Recommended to leave at 'true' _unless_ launching in a public subnet | `string` | `"true"` | no |
| <a name="input_NotificationEmail"></a> [NotificationEmail](#input\_NotificationEmail) | (Optional) Email address to subscribe to notifications and alarms | `string` | `""` | no |
| <a name="input_PatchSchedule"></a> [PatchSchedule](#input\_PatchSchedule) | Schedule used to apply patches to the instance | `string` | `"cron(0 6 ? * Sat *)"` | no |
| <a name="input_PatchSnsTopicArn"></a> [PatchSnsTopicArn](#input\_PatchSnsTopicArn) | SNS Topic used for patch status notifications | `string` | `""` | no |
| <a name="input_RdcbDnszoneId"></a> [RdcbDnszoneId](#input\_RdcbDnszoneId) | Zone to create DNS record for RDCB instance | `string` | `""` | no |
| <a name="input_RemoteAccessScriptsUrl"></a> [RemoteAccessScriptsUrl](#input\_RemoteAccessScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/terraform-aws-remote-access/master"` | no |
| <a name="input_SecurityGroupIngress"></a> [SecurityGroupIngress](#input\_SecurityGroupIngress) | List of security group IPs to allow | `list(string)` | `[]` | no |
| <a name="input_SnapshotFrequency"></a> [SnapshotFrequency](#input\_SnapshotFrequency) | (Optional) Specify an interval in minutes to configure snapshots of the EBS fileshare volume. Set an empty value "" to skip configuring snapshots. Default interval is 60 minutes. | `string` | `"60"` | no |
| <a name="input_SsmKeyId"></a> [SsmKeyId](#input\_SsmKeyId) | KMS Key ID used to encrypt/decrypt the SsmRdcbCredential | `string` | `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` | no |
| <a name="input_SsmRdcbCredential"></a> [SsmRdcbCredential](#input\_SsmRdcbCredential) | SSM Parameter Name for a SecureString containing the domain credential for the RDCB service account. SSM Parameter Value format is '@{Username = "<user>"; Password = "<password>"}' | `string` | `"/your-path/rdcb/credential"` | no |
| <a name="input_TerminationProtection"></a> [TerminationProtection](#input\_TerminationProtection) | Enable or disable instance termination protection.  Protection is enabled by default. | `string` | `true` | no |
| <a name="input_UtilityScriptsUrl"></a> [UtilityScriptsUrl](#input\_UtilityScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/utils/master"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rdcb-dns-zone-id"></a> [rdcb-dns-zone-id](#output\_rdcb-dns-zone-id) | n/a |
| <a name="output_rdcb-fqdn"></a> [rdcb-fqdn](#output\_rdcb-fqdn) | n/a |
| <a name="output_rdcb-hostname"></a> [rdcb-hostname](#output\_rdcb-hostname) | n/a |
| <a name="output_rdcb-instance-id"></a> [rdcb-instance-id](#output\_rdcb-instance-id) | n/a |
| <a name="output_rdcb-instance-ip"></a> [rdcb-instance-ip](#output\_rdcb-instance-ip) | n/a |
| <a name="output_rdcb-sg-id"></a> [rdcb-sg-id](#output\_rdcb-sg-id) | n/a |
| <a name="output_rdcb-sns-arn"></a> [rdcb-sns-arn](#output\_rdcb-sns-arn) | n/a |
| <a name="output_rdsh-sg-id"></a> [rdsh-sg-id](#output\_rdsh-sg-id) | n/a |

<!-- END TFDOCS -->

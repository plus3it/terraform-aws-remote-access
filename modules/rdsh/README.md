# rdsh

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudformation_stack) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AmiLookupLambdaArn"></a> [AmiLookupLambdaArn](#input\_AmiLookupLambdaArn) | Arn of the ami-lookup-id lambda. See https://github.com/plus3it/lookup-ami-ids for more details. | `string` | n/a | yes |
| <a name="input_DomainSvcAccount"></a> [DomainSvcAccount](#input\_DomainSvcAccount) | User name for the account that will join the instance to the Connection Broker Cluster | `string` | n/a | yes |
| <a name="input_DomainSvcPassword"></a> [DomainSvcPassword](#input\_DomainSvcPassword) | Password for the Connection Broker service account. Must be at least 8 characters containing letters, numbers and symbols | `string` | n/a | yes |
| <a name="input_RdpPrivateKeyPassword"></a> [RdpPrivateKeyPassword](#input\_RdpPrivateKeyPassword) | Password to the RDP certificate private key | `string` | n/a | yes |
| <a name="input_RdpPrivateKeyPfx"></a> [RdpPrivateKeyPfx](#input\_RdpPrivateKeyPfx) | S3 bucket and path to a private key for the RDP certificate, e.g. '<bucket>/path/to/key.pfx' | `string` | n/a | yes |
| <a name="input_StackName"></a> [StackName](#input\_StackName) | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| <a name="input_VpcId"></a> [VpcId](#input\_VpcId) | VPC to deploy instance(s) into | `string` | n/a | yes |
| <a name="input_AmiFilters"></a> [AmiFilters](#input\_AmiFilters) | List of maps with additional ami search filters | <pre>list(object(<br/>    {<br/>      Name   = string,<br/>      Values = list(string)<br/>    }<br/>  ))</pre> | <pre>[<br/>  {<br/>    "Name": "name",<br/>    "Values": [<br/>      "Windows_Server-2016-English-Full-Base-*"<br/>    ]<br/>  }<br/>]</pre> | no |
| <a name="input_AmiId"></a> [AmiId](#input\_AmiId) | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| <a name="input_AmiOwners"></a> [AmiOwners](#input\_AmiOwners) | List of owners to filter ami search results against | `list(string)` | <pre>[<br/>  "amazon"<br/>]</pre> | no |
| <a name="input_CloudWatchAgentUrl"></a> [CloudWatchAgentUrl](#input\_CloudWatchAgentUrl) | (Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| <a name="input_ConnectionBrokerFqdn"></a> [ConnectionBrokerFqdn](#input\_ConnectionBrokerFqdn) | Fully qualified domain name (FQDN) of the primary Connection Broker, e.g. 'cb.example.com' | `string` | `""` | no |
| <a name="input_DesiredCapacity"></a> [DesiredCapacity](#input\_DesiredCapacity) | The number of instances the autoscale group will spin up initially | `string` | `"1"` | no |
| <a name="input_DnsName"></a> [DnsName](#input\_DnsName) | Name of Host A DNS Record | `string` | `""` | no |
| <a name="input_DomainAccessUserGroup"></a> [DomainAccessUserGroup](#input\_DomainAccessUserGroup) | Domain group of users authorized to use the RDSH | `string` | `"Domain Users"` | no |
| <a name="input_DomainDirectoryId"></a> [DomainDirectoryId](#input\_DomainDirectoryId) | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | `""` | no |
| <a name="input_DomainDnsName"></a> [DomainDnsName](#input\_DomainDnsName) | Fully qualified domain name (FQDN) of the forest root domain e.g. example.com | `string` | `"example.com"` | no |
| <a name="input_DomainNetbiosName"></a> [DomainNetbiosName](#input\_DomainNetbiosName) | Netbios name of the domain (e.g. EXAMPLE) | `string` | `"EXAMPLE"` | no |
| <a name="input_ExtraSecurityGroupIds"></a> [ExtraSecurityGroupIds](#input\_ExtraSecurityGroupIds) | Comma separated string of extra Security Group IDs to attach to the RDSH instances -- include _at least_ the SG allowing connectivity to the Connection Broker database | `list(string)` | `[]` | no |
| <a name="input_ForceUpdateToggle"></a> [ForceUpdateToggle](#input\_ForceUpdateToggle) | A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy | `string` | `"A"` | no |
| <a name="input_InstanceType"></a> [InstanceType](#input\_InstanceType) | Amazon EC2 instance type for the Remote Desktop Session Instance | `string` | `"t2.medium"` | no |
| <a name="input_KeyPairName"></a> [KeyPairName](#input\_KeyPairName) | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `""` | no |
| <a name="input_LdapContainerOU"></a> [LdapContainerOU](#input\_LdapContainerOU) | DN of the LDAP container or OU in which the RDSH instance will be placed | `string` | `"OU=Users,DC=example,DC=com"` | no |
| <a name="input_MaxCapacity"></a> [MaxCapacity](#input\_MaxCapacity) | The maximum number of instances for the autoscale group | `string` | `"2"` | no |
| <a name="input_MinCapacity"></a> [MinCapacity](#input\_MinCapacity) | The minimum number of instances for the autoscale group | `string` | `"0"` | no |
| <a name="input_NlbZones"></a> [NlbZones](#input\_NlbZones) | Map of NLB Zones | `map(string)` | <pre>{<br/>  "us-east-1": "Z26RNL4JYFTOTI",<br/>  "us-east-2": "ZLMOA37VPKANP",<br/>  "us-west-1": "Z24FKFUX50B4VW",<br/>  "us-west-2": "Z18D5FSROUN65G"<br/>}</pre> | no |
| <a name="input_PrivateDnszoneId"></a> [PrivateDnszoneId](#input\_PrivateDnszoneId) | ZoneId where DNS record will be created for the RDSH nodes | `string` | `""` | no |
| <a name="input_RdpPrivateKeyS3Endpoint"></a> [RdpPrivateKeyS3Endpoint](#input\_RdpPrivateKeyS3Endpoint) | S3 endpoint URL hosting the bucket where the RDP certificate private key is stored | `string` | `"https://s3.amazonaws.com"` | no |
| <a name="input_RemoteAccessScriptsUrl"></a> [RemoteAccessScriptsUrl](#input\_RemoteAccessScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/terraform-aws-remote-access/master"` | no |
| <a name="input_S3Bucket"></a> [S3Bucket](#input\_S3Bucket) | n/a | `string` | `"your_bucket"` | no |
| <a name="input_ScaleDownDesiredCapacity"></a> [ScaleDownDesiredCapacity](#input\_ScaleDownDesiredCapacity) | (Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset | `string` | `"1"` | no |
| <a name="input_ScaleDownSchedule"></a> [ScaleDownSchedule](#input\_ScaleDownSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 * * *') | `string` | `""` | no |
| <a name="input_ScaleUpSchedule"></a> [ScaleUpSchedule](#input\_ScaleUpSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 * * Mon-Fri') | `string` | `""` | no |
| <a name="input_SubnetIDs"></a> [SubnetIDs](#input\_SubnetIDs) | List of Subnet IDs where the RDSH instances and ELB will be launched | `list(string)` | `[]` | no |
| <a name="input_UpdateSchedule"></a> [UpdateSchedule](#input\_UpdateSchedule) | (Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | no |
| <a name="input_UserProfileDiskPath"></a> [UserProfileDiskPath](#input\_UserProfileDiskPath) | Path to a CIFS share where User Profile Disks are stored, e.g. [ "home.example.com", "Profiles$" ] eq "\\\home.example.com\Profiles$" | `list(string)` | <pre>[<br/>  "home.example.com",<br/>  "Profiles$"<br/>]</pre> | no |
| <a name="input_UtilityScriptsUrl"></a> [UtilityScriptsUrl](#input\_UtilityScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/utils/master"` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->

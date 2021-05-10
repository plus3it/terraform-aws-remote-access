# guac

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AmiLookupLambdaArn"></a> [AmiLookupLambdaArn](#input\_AmiLookupLambdaArn) | Arn of the ami-lookup-id lambda. See https://github.com/plus3it/lookup-ami-ids for more details. | `string` | n/a | yes |
| <a name="input_GuacDnsZoneId"></a> [GuacDnsZoneId](#input\_GuacDnsZoneId) | Id of DNS zone for Guac Load Balancer DNS Record | `string` | n/a | yes |
| <a name="input_LdapDN"></a> [LdapDN](#input\_LdapDN) | Distinguished Name (DN) of the LDAP directory.  E.g. DC=domain,DC=com | `string` | n/a | yes |
| <a name="input_LdapServer"></a> [LdapServer](#input\_LdapServer) | Name of LDAP server Guacamole will authenticate against.  E.g. domain.com | `string` | n/a | yes |
| <a name="input_PrivateSubnetIds"></a> [PrivateSubnetIds](#input\_PrivateSubnetIds) | List of Private Subnet IDs where the Guacamole instances will run | `list(string)` | n/a | yes |
| <a name="input_PublicSubnetIds"></a> [PublicSubnetIds](#input\_PublicSubnetIds) | List of Public subnet IDs to attach to the Application Load Balancer | `list(string)` | n/a | yes |
| <a name="input_SslCertificateName"></a> [SslCertificateName](#input\_SslCertificateName) | The name (for IAM) or identifier (for ACM) of the SSL certificate to associate with the ALB -- the cert must already exist in the service | `string` | n/a | yes |
| <a name="input_StackName"></a> [StackName](#input\_StackName) | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| <a name="input_VpcId"></a> [VpcId](#input\_VpcId) | VPC to deploy instance(s) into | `string` | n/a | yes |
| <a name="input_AmiFilters"></a> [AmiFilters](#input\_AmiFilters) | List of maps with additional ami search filters | <pre>list(object(<br>    {<br>      Name   = string,<br>      Values = list(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "Name": "name",<br>    "Values": [<br>      "amzn-ami-hvm-2018.03.*-x86_64-gp2"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_AmiId"></a> [AmiId](#input\_AmiId) | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| <a name="input_AmiOwners"></a> [AmiOwners](#input\_AmiOwners) | List of owners to filter ami search results against | `list(string)` | <pre>[<br>  "amazon"<br>]</pre> | no |
| <a name="input_BrandText"></a> [BrandText](#input\_BrandText) | Text/Label to display branding for the Guac Login page | `string` | `"Remote Access"` | no |
| <a name="input_Capabilities"></a> [Capabilities](#input\_Capabilities) | Required IAM capabilities | `list(string)` | <pre>[<br>  "CAPABILITY_AUTO_EXPAND",<br>  "CAPABILITY_NAMED_IAM",<br>  "CAPABILITY_IAM"<br>]</pre> | no |
| <a name="input_CloudWatchAgentUrl"></a> [CloudWatchAgentUrl](#input\_CloudWatchAgentUrl) | (Optional) S3 URL to CloudWatch Agent installer. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `"s3://amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"` | no |
| <a name="input_DesiredCapacity"></a> [DesiredCapacity](#input\_DesiredCapacity) | The number of instances the autoscale group will spin up initially | `string` | `"1"` | no |
| <a name="input_DisableRollback"></a> [DisableRollback](#input\_DisableRollback) | Set to true to disable rollback of the stack if stack creation failed. Conflicts with OnFailure | `string` | `false` | no |
| <a name="input_DockerGuacamoleImage"></a> [DockerGuacamoleImage](#input\_DockerGuacamoleImage) | Identifier for GUACAMOLE docker image. Used by docker pull to retrieve the guacamole image | `string` | `"guacamole/guacamole:1.2.0"` | no |
| <a name="input_DockerGuacdImage"></a> [DockerGuacdImage](#input\_DockerGuacdImage) | Identifier for GUACD docker image. Used by docker pull to retrieve the guacd image | `string` | `"guacamole/guacd:1.2.0"` | no |
| <a name="input_ElbZones"></a> [ElbZones](#input\_ElbZones) | Map of ELB Zones | `map(string)` | <pre>{<br>  "us-east-1": "Z35SXDOTRQ7X7K",<br>  "us-east-2": "Z3AADJGX6KTTL2",<br>  "us-west-1": "Z368ELLRRE2KJ0",<br>  "us-west-2": "Z1H1FL5HABSF5"<br>}</pre> | no |
| <a name="input_ForceUpdateToggle"></a> [ForceUpdateToggle](#input\_ForceUpdateToggle) | A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy | `string` | `"B"` | no |
| <a name="input_GuacBaseDN"></a> [GuacBaseDN](#input\_GuacBaseDN) | The base of the DN for all Guacamole configurations. | `string` | `"CN=GuacConfigGroups"` | no |
| <a name="input_GuacPublicDnsHostname"></a> [GuacPublicDnsHostname](#input\_GuacPublicDnsHostname) | Hostname of DNS record used to reach Guac Elb | `string` | `"guacamole"` | no |
| <a name="input_IamRoleArn"></a> [IamRoleArn](#input\_IamRoleArn) | The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials | `string` | `""` | no |
| <a name="input_InstanceType"></a> [InstanceType](#input\_InstanceType) | Amazon EC2 instance type for the Remote Desktop Session Instance | `string` | `"c5.large"` | no |
| <a name="input_KeyPairName"></a> [KeyPairName](#input\_KeyPairName) | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `""` | no |
| <a name="input_MaxCapacity"></a> [MaxCapacity](#input\_MaxCapacity) | The maximum number of instances for the autoscale group | `string` | `"1"` | no |
| <a name="input_MinCapacity"></a> [MinCapacity](#input\_MinCapacity) | The minimum number of instances for the autoscale group | `string` | `"0"` | no |
| <a name="input_NotificationArns"></a> [NotificationArns](#input\_NotificationArns) | A list of SNS topic ARNs to publish stack related events | `list(string)` | `[]` | no |
| <a name="input_OnFailureAction"></a> [OnFailureAction](#input\_OnFailureAction) | Action to be taken if stack creation fails. This must be one of: DO\_NOTHING, ROLLBACK, or DELETE. Conflicts with DisableRollback | `string` | `"ROLLBACK"` | no |
| <a name="input_PolicyBody"></a> [PolicyBody](#input\_PolicyBody) | String containing the stack policy body. Conflicts with PolicyUrl | `string` | `""` | no |
| <a name="input_PolicyUrl"></a> [PolicyUrl](#input\_PolicyUrl) | URL to a file containing the stack policy. Conflicts with PolicyBody | `string` | `""` | no |
| <a name="input_RemoteAccessScriptsUrl"></a> [RemoteAccessScriptsUrl](#input\_RemoteAccessScriptsUrl) | URL prefix where the remote access scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/terraform-aws-remote-access/master"` | no |
| <a name="input_ScaleDownDesiredCapacity"></a> [ScaleDownDesiredCapacity](#input\_ScaleDownDesiredCapacity) | (Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset | `string` | `"1"` | no |
| <a name="input_ScaleDownSchedule"></a> [ScaleDownSchedule](#input\_ScaleDownSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. '0 0 * * *') | `string` | `""` | no |
| <a name="input_ScaleUpSchedule"></a> [ScaleUpSchedule](#input\_ScaleUpSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. '0 10 * * Mon-Fri') | `string` | `""` | no |
| <a name="input_SslCertificateService"></a> [SslCertificateService](#input\_SslCertificateService) | The service hosting the SSL certificate | `string` | `"ACM"` | no |
| <a name="input_StackCreateTimeout"></a> [StackCreateTimeout](#input\_StackCreateTimeout) | The amount of time in minutes before the stack create fails | `string` | `"20"` | no |
| <a name="input_StackDeleteTimeout"></a> [StackDeleteTimeout](#input\_StackDeleteTimeout) | The amount of time in minutes before the stack delete fails | `string` | `"20"` | no |
| <a name="input_StackTags"></a> [StackTags](#input\_StackTags) | A map of tag keys/values to associate with this stack | `map(string)` | `{}` | no |
| <a name="input_StackUpdateTimeout"></a> [StackUpdateTimeout](#input\_StackUpdateTimeout) | The amount of time in minutes before the stack update fails | `string` | `"20"` | no |
| <a name="input_URL1"></a> [URL1](#input\_URL1) | First custom URL/link to display on the Guac Login page | `string` | `"https://accounts.domain.com"` | no |
| <a name="input_URL2"></a> [URL2](#input\_URL2) | Second custom URL/link to display on the Guac Login page | `string` | `"https://redmine.domain.com"` | no |
| <a name="input_URLText1"></a> [URLText1](#input\_URLText1) | Text/Label to display for the First custom URL/link displayed on the Guac Login page | `string` | `"Account Services"` | no |
| <a name="input_URLText2"></a> [URLText2](#input\_URLText2) | Text/Label to display for the Second custom URL/link displayed on the Guac Login page | `string` | `"Redmine"` | no |
| <a name="input_UpdateSchedule"></a> [UpdateSchedule](#input\_UpdateSchedule) | (Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `"cron(0 5 ? * Sun *)"` | no |

## Outputs

No outputs.

<!-- END TFDOCS -->

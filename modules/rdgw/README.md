# rdgw

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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AmiLookupLambdaArn"></a> [AmiLookupLambdaArn](#input\_AmiLookupLambdaArn) | Arn of the ami-lookup-id lambda. See https://github.com/plus3it/lookup-ami-ids for more details. | `string` | n/a | yes |
| <a name="input_DomainDirectoryId"></a> [DomainDirectoryId](#input\_DomainDirectoryId) | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | n/a | yes |
| <a name="input_PrivateSubnetIds"></a> [PrivateSubnetIds](#input\_PrivateSubnetIds) | Comma separated string of Private Subnet IDs where the RDGW instances will run | `list(string)` | n/a | yes |
| <a name="input_PublicSubnetIds"></a> [PublicSubnetIds](#input\_PublicSubnetIds) | Comma separated string of Public subnet IDs to attach to the load balancer | `list(string)` | n/a | yes |
| <a name="input_S3Bucket"></a> [S3Bucket](#input\_S3Bucket) | n/a | `any` | n/a | yes |
| <a name="input_StackName"></a> [StackName](#input\_StackName) | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| <a name="input_VpcId"></a> [VpcId](#input\_VpcId) | VPC to deploy instance into | `string` | n/a | yes |
| <a name="input_AmiFilters"></a> [AmiFilters](#input\_AmiFilters) | List of maps with additional ami search filters | <pre>list(object(<br/>    {<br/>      Name   = string,<br/>      Values = list(string)<br/>    }<br/>  ))</pre> | <pre>[<br/>  {<br/>    "Name": "name",<br/>    "Values": [<br/>      "Windows_Server-2016-English-Full-Base-*"<br/>    ]<br/>  }<br/>]</pre> | no |
| <a name="input_AmiId"></a> [AmiId](#input\_AmiId) | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| <a name="input_AmiOwners"></a> [AmiOwners](#input\_AmiOwners) | List of owners to filter ami search results against | `list(string)` | <pre>[<br/>  "amazon"<br/>]</pre> | no |
| <a name="input_AuthenticationMethod"></a> [AuthenticationMethod](#input\_AuthenticationMethod) | Configures the RDGW for either Password or Smartcard authentication | `string` | `"Password"` | no |
| <a name="input_CloudWatchAgentUrl"></a> [CloudWatchAgentUrl](#input\_CloudWatchAgentUrl) | (Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| <a name="input_DesiredCapacity"></a> [DesiredCapacity](#input\_DesiredCapacity) | The number of instances the autoscale group will spin up initially | `string` | `"1"` | no |
| <a name="input_DnsName"></a> [DnsName](#input\_DnsName) | Hostname of A record created | `string` | `""` | no |
| <a name="input_DomainDnsName"></a> [DomainDnsName](#input\_DomainDnsName) | Fully qualified domain name (FQDN) of the forest root domain e.g. example.com | `string` | `"example.com"` | no |
| <a name="input_DomainNetbiosName"></a> [DomainNetbiosName](#input\_DomainNetbiosName) | NetBIOS name of the domain (e.g. EXAMPLE) | `string` | `"EXAMPLE"` | no |
| <a name="input_ForceUpdateToggle"></a> [ForceUpdateToggle](#input\_ForceUpdateToggle) | A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy | `string` | `"A"` | no |
| <a name="input_InstanceType"></a> [InstanceType](#input\_InstanceType) | Amazon EC2 instance type for the Remote Desktop Gateway Instance | `string` | `"t2.micro"` | no |
| <a name="input_KeyPairName"></a> [KeyPairName](#input\_KeyPairName) | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `""` | no |
| <a name="input_MaxCapacity"></a> [MaxCapacity](#input\_MaxCapacity) | The maximum number of instances for the autoscale group | `string` | `"2"` | no |
| <a name="input_MinCapacity"></a> [MinCapacity](#input\_MinCapacity) | The minimum number of instances for the autoscale group | `string` | `"0"` | no |
| <a name="input_PublicDnszoneId"></a> [PublicDnszoneId](#input\_PublicDnszoneId) | Public DNS Zone where the RDGW record will be created | `string` | `""` | no |
| <a name="input_RemoteAccessScriptsUrl"></a> [RemoteAccessScriptsUrl](#input\_RemoteAccessScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/terraform-aws-remote-access/master"` | no |
| <a name="input_RemoteAccessUserGroup"></a> [RemoteAccessUserGroup](#input\_RemoteAccessUserGroup) | Domain group of users authorized to use the RDGW | `string` | `"Domain Admins"` | no |
| <a name="input_ScaleDownDesiredCapacity"></a> [ScaleDownDesiredCapacity](#input\_ScaleDownDesiredCapacity) | (Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset | `string` | `"1"` | no |
| <a name="input_ScaleDownSchedule"></a> [ScaleDownSchedule](#input\_ScaleDownSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. "0 0 * * *") | `string` | `""` | no |
| <a name="input_ScaleUpSchedule"></a> [ScaleUpSchedule](#input\_ScaleUpSchedule) | (Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. "0 10 * * Mon-Fri") | `string` | `""` | no |
| <a name="input_SslCertificateName"></a> [SslCertificateName](#input\_SslCertificateName) | The name (for IAM) or identifier (for ACM) of the SSL certificate to associate with the LB -- the cert must already exist in the service | `string` | `""` | no |
| <a name="input_SslCertificateService"></a> [SslCertificateService](#input\_SslCertificateService) | The service hosting the SSL certificate.  ACM or IAM are allowed values | `string` | `"ACM"` | no |
| <a name="input_UpdateSchedule"></a> [UpdateSchedule](#input\_UpdateSchedule) | (Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | no |
| <a name="input_UtilityScriptsUrl"></a> [UtilityScriptsUrl](#input\_UtilityScriptsUrl) | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/plus3it/utils/master"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rdgw-alb-security-group-id"></a> [rdgw-alb-security-group-id](#output\_rdgw-alb-security-group-id) | n/a |
| <a name="output_rdgw-ec2-security-group-id"></a> [rdgw-ec2-security-group-id](#output\_rdgw-ec2-security-group-id) | n/a |
| <a name="output_rdgw-load-balancer-dns"></a> [rdgw-load-balancer-dns](#output\_rdgw-load-balancer-dns) | n/a |
| <a name="output_rdgw-load-balancer-name"></a> [rdgw-load-balancer-name](#output\_rdgw-load-balancer-name) | n/a |
| <a name="output_rdgw-load-balancer-zone-id"></a> [rdgw-load-balancer-zone-id](#output\_rdgw-load-balancer-zone-id) | n/a |

<!-- END TFDOCS -->

# rdgw

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| AmiLookupLambdaArn | Arn of the ami-lookup-id lambda. See https://github.com/plus3it/lookup-ami-ids for more details. | `string` | n/a | yes |
| DomainDirectoryId | ID of the AWS Directory Service domain, e.g. d-xxxxxxxxxx | `string` | n/a | yes |
| PrivateSubnetIds | Comma separated string of Private Subnet IDs where the RDGW instances will run | `list(string)` | n/a | yes |
| PublicSubnetIds | Comma separated string of Public subnet IDs to attach to the load balancer | `list(string)` | n/a | yes |
| S3Bucket | n/a | `any` | n/a | yes |
| StackName | CloudFormation Stack Name.  Must be less than 10 characters | `string` | n/a | yes |
| VpcId | VPC to deploy instance into | `string` | n/a | yes |
| AmiFilters | List of maps with additional ami search filters | <pre>list(object(<br>    {<br>      Name   = string,<br>      Values = list(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "Name": "name",<br>    "Values": [<br>      "Windows_Server-2016-English-Full-Base-*"<br>    ]<br>  }<br>]</pre> | no |
| AmiId | (Optional) AMI ID -- will supersede Lambda-based AMI lookup using AmiNameSearchString | `string` | `""` | no |
| AmiOwners | List of owners to filter ami search results against | `list(string)` | <pre>[<br>  "amazon"<br>]</pre> | no |
| AuthenticationMethod | Configures the RDGW for either Password or Smartcard authentication | `string` | `"Password"` | no |
| CloudWatchAgentUrl | (Optional) S3 URL to CloudWatch Agent MSI. Example: s3://amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi | `string` | `""` | no |
| DesiredCapacity | The number of instances the autoscale group will spin up initially | `string` | `"1"` | no |
| DnsName | Hostname of A record created | `string` | `""` | no |
| DomainDnsName | Fully qualified domain name (FQDN) of the forest root domain e.g. example.com | `string` | `"example.com"` | no |
| DomainNetbiosName | NetBIOS name of the domain (e.g. EXAMPLE) | `string` | `"EXAMPLE"` | no |
| ForceUpdateToggle | A/B toggle that forces a change to a LaunchConfig property, triggering the AutoScale Update Policy | `string` | `"A"` | no |
| InstanceType | Amazon EC2 instance type for the Remote Desktop Gateway Instance | `string` | `"t2.micro"` | no |
| KeyPairName | Public/private key pairs allow you to securely connect to your instance after it launches | `string` | `""` | no |
| MaxCapacity | The maximum number of instances for the autoscale group | `string` | `"2"` | no |
| MinCapacity | The minimum number of instances for the autoscale group | `string` | `"0"` | no |
| PublicDnszoneId | Public DNS Zone where the RDGW record will be created | `string` | `""` | no |
| RemoteAccessScriptsUrl | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/terraform-aws-remote-access/master"` | no |
| RemoteAccessUserGroup | Domain group of users authorized to use the RDGW | `string` | `"Domain Admins"` | no |
| ScaleDownDesiredCapacity | (Optional) Desired number of instances during the Scale Down Scheduled Action; ignored if ScaleDownSchedule is unset | `string` | `"1"` | no |
| ScaleDownSchedule | (Optional) Scheduled Action in cron-format (UTC) to scale down the number of instances; ignored if empty or ScaleUpSchedule is unset (E.g. "0 0 \* \* \*") | `string` | `""` | no |
| ScaleUpSchedule | (Optional) Scheduled Action in cron-format (UTC) to scale up to the Desired Capacity; ignored if empty or ScaleDownSchedule is unset (E.g. "0 10 \* \* Mon-Fri") | `string` | `""` | no |
| SslCertificateName | The name (for IAM) or identifier (for ACM) of the SSL certificate to associate with the LB -- the cert must already exist in the service | `string` | `""` | no |
| SslCertificateService | The service hosting the SSL certificate.  ACM or IAM are allowed values | `string` | `"ACM"` | no |
| UpdateSchedule | (Optional) Time interval between auto stack updates. Refer to the AWS documentation for valid input syntax: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html | `string` | `""` | no |
| UtilityScriptsUrl | URL prefix where the repo scripts can be retrieved | `string` | `"https://raw.githubusercontent.com/utils/master"` | no |

## Outputs

| Name | Description |
|------|-------------|
| rdgw-alb-security-group-id | n/a |
| rdgw-ec2-security-group-id | n/a |
| rdgw-load-balancer-dns | n/a |
| rdgw-load-balancer-name | n/a |
| rdgw-load-balancer-zone-id | n/a |

<!-- END TFDOCS -->

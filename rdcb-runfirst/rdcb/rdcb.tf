data "aws_cloudformation_stack" "rdcb" {
  name = "${var.stackname}"
  depends_on = ["null_resource.push-changeset"]
}

data "local_file" "rdcb_hostname" {
   filename = "rdcb-hostname.txt"
    depends_on = ["null_resource.get_ec2_hostname"]
}

resource "aws_route53_record" "private_dns_record" {
 zone_id = "${var.rdcb_dnszone_id}"
 name    = "${var.stackname}"
 type    = "A"
 ttl = "300"
 records = ["${data.aws_cloudformation_stack.rdcb.outputs["RdcbEc2InstanceIp"]}"]
 depends_on = ["data.aws_cloudformation_stack.rdcb"]
}

resource "aws_security_group" "rdcb-sg1" {
  name_prefix = "${var.stackname}-"
  description = "Security group for accessing rdcb"

  vpc_id = "${var.VpcId}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = ["${aws_security_group.rdsh-sg1.id}"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.stackname}-rdcb-sg1"
    Terraform = "True"
  }
}

resource "aws_security_group" "rdsh-sg1" {
  name_prefix = "${var.stackname}-"
  description = "Security group for accessing rdsh"

  vpc_id = "${var.VpcId}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${var.stackname}-rdsh-sg1"
    Terraform = "True"
  }
}

resource "null_resource" "push-changeset" {
  provisioner "local-exec" {
    command     = "${join(" ", local.create_changeset_command)}"
    working_dir = ".."
    
  }

  provisioner "local-exec" {
    command = "${join(" ", local.destroy_changeset_command)}"
    when    = "destroy"
  }
  depends_on = ["aws_security_group.rdcb-sg1"]
  depends_on = ["aws_security_group.rdsh-sg1"]
}

resource "null_resource" "get_ec2_hostname" {
  provisioner "local-exec" {
    command = "${join(" ", local.get_ec2_hostname)}"
  }

  triggers = {
    instance_ids = "${join(",", null_resource.push-changeset.*.id)}"
  }
}

locals {
  create_changeset_command = [
    "aws cloudformation deploy --template",
    "cfn/ra_rdcb_fileserver_standalone.template.cfn.json",
    " --stack-name ${var.stackname}",
    " --s3-bucket ${var.s3bucket}",
    " --parameter-overrides",
    "\"AmiId=${var.amiid}\"",
    "\"AmiNameSearchString=${var.aminamesearchstring}\"",
    "\"DataVolumeSize=${var.datavolumesize}\"",
    "\"DataVolumeSnapshotid=${var.datavolumesnapshotid}\"",
    "\"DomainAccessUserGroup=${var.domainaccessusergroup}\"",
    "\"DomainDirectoryId=${var.domaindirectoryid}\"",
    "\"DomainDnsName=${var.domaindnsname}\"",
    "\"DomainNetbiosName=${var.DomainNetbiosName}\"",
    "\"Ec2SubnetAz=${var.ec2subnetaz}\"",
    "\"Ec2SubnetId=${var.Ec2SubnetId}\"",
    "\"ExtraSecurityGroupIds=${aws_security_group.rdcb-sg1.id},${var.ExtraSecurityGroupIds}\"",
    "\"InstanceType=${var.InstanceType}\"",
    "\"KeyPairName=${var.KeyPairName}\"",
    "\"NoPublicIp=${var.NoPublicIp}\"",
    "\"NotificationEmail=${var.NotificationEmail}\"",
    "\"SsmKeyId=${var.SsmKeyId}\"",
    "\"SsmRdcbCredential=${var.SsmRdcbCredential}\"",
    "\"VpcId=${var.VpcId}\"",
    "\"CloudWatchAgentUrl=${var.CloudWatchAgentUrl}\"",
    "--capabilities CAPABILITY_IAM",
  ]

  get_ec2_hostname = [
    "aws ec2 get-console-output --instance-id \"${data.aws_cloudformation_stack.rdcb.outputs["RdcbEc2InstanceId"]}\"",
    " --output text | awk '/RDPCERTIFICATE-SUBJECTNAME: /{print $NF}' | sed 's/\r$//' | xargs echo -n > rdcb-hostname.txt"
  ]

  destroy_changeset_command = [
    "aws cloudformation delete-stack --stack-name ${var.stackname}",
  ]
}


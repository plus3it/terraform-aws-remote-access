# terra-rdsh

Run terraform apply in terraform-aws-rdcb.  This takes about 20 minutes to complete.

Once that is complete, run terraform apply in the terraform-aws-rdgw folder.  This takes about 10 minutes.

This task can be run concurrent to terraform-aws-rdgw.  Run terraform apply in the terraform-aws-rdsh folder.  This can take from 30-60 minutes.


For the rdsh module to complete successfully, some outputs from the rdcb module will need fed into the rdsh module parameters.

When deploying the stack using Terragrunt, the following variables could be used when defining the rdsh resource.
* "ConnectionBrokerFqdn" = "${module.rdcb.rdcb_hostname}"
* "ExtraSecurityGroupIds" = "${module.rdcb.rdsh_sg_id}
* "UserProfileDiskPath" = "\\\\\\\\${module.rdcb.rdcb_hostname}\\\\${var.Rdsh-UserProfileDiskPath}"
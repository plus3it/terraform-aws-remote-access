# terra-rdsh

Place these four files in a "cfn" folder in the root of the project.  They are available here: https://github.com/plus3it/cfn/tree/master/templates

* ra_guac_autoscale_public_alb.template.cfn.json
* ra_rdcb_fileserver_standalone.template.cfn.json
* ra_rdgw_autoscale_public_lb.template.cfn.json
* ra_rdsh_autoscale_internal_elb.template.cfn.json


Run terraform apply in rdcb-runfirst.  This takes about 20 minutes to complete.

Once that is complete, run terraform apply in the rdgw-runsecond folder.  This takes about 10 minutes.

This task can be run concurrent to rdgw-runsecond.  Run terraform apply in the rdsh-runthird folder.  This can take from 30-60 minutes.


For the rdsh module to complete successfully, some outputs from the rdcb module will need fed into the rdsh module parameters.  When deploying the stack using Terragrunt, the following variables could be used when defining the rdsh resource.
* "ConnectionBrokerFqdn" = "${module.rdcb.rdcb_hostname}"
* "ExtraSecurityGroupIds" = "${module.rdcb.rdsh_sg_id}
* "UserProfileDiskPath" = "\\\\\\\\${module.rdcb.rdcb_hostname}\\\\${var.Rdsh-UserProfileDiskPath}"
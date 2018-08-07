# terra-rdsh

Place these four files in a "cfn" folder in the root of the project.  They are available here: https://github.com/plus3it/terraform-aws-watchmaker/tree/master/modules.

* ra_guac_autoscale_public_alb.template.cfn.json
* ra_rdcb_fileserver_standalone.template.cfn.json
* ra_rdgw_autoscale_public_alb.template.cfn.json
* ra_rdsh_autoscale_internal_elb.template.cfn.json


Fill out the terraform.tfvar.template file in each folder with your variables.  Remove the .template nomenclature.

Run terraform plan in rdcb-runfirst.  This takes about 20 minutes to complete.

Once that is complete, run terraform apply in the rdgw-runsecond folder.  This takes about 10 minutes.

Create DNS Record for RDGW in private DNS Zone?
Create DNS Record for RDGW ELB in Public DNS Zone?


Once that is complete, run terraform apply in the rdsh-runthird folder.

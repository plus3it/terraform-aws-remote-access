# terra-rdsh

Place these four files in a "cfn" folder in each module.  They are available here: https://github.com/plus3it/terraform-aws-watchmaker/tree/master/modules.

ra_guac_autoscale_public_alb.template.cfn.json
ra_rdcb_fileserver_standalone.template.cfn.json
ra_rdgw_autoscale_public_alb.template.cfn.json
ra_rdsh_autoscale_internal_elb.template.cfn.json

For example, after cloning the repo to your local system, create a folder called "cfn" in the rdcb-runfirst folder and place the templates in the folder.  Do the same for the rest of the folders.

Fill out the terraform.tfvar.template file in each folder with your variables.  Remove the .template nomenclature.

Run terraform plan in rdcb-runfirst.  Once that is complete, gather the outputs of the stack for use in the next folder: rdgw-runsecond

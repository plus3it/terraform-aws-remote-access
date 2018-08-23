[ ]Re-write RDCB hostname lookup to be ephemeral
#here's a python wrapper for the terraform external interface, #https://github.com/plus3it/terraform-external-file-cache/blob/master/tf_external/__init__.py
#drop that path/file in your repo and in the root of your project, add a python script that uses that interface to wrap your #function, https://github.com/plus3it/terraform-external-file-cache/blob/master/file_cache.py
#then your terraform resource looks more or less like this: #https://github.com/plus3it/terraform-external-file-cache/blob/master/main.tf#L1-L11
#this should be the python boto3 call, #https://boto3.readthedocs.io/en/latest/reference/services/ec2.html#EC2.Client.get_console_output

[ ]Orchestrate deployment of the modules
[ ]Update documentation
[ ]Successful RDSH deployment


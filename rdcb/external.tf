##Try to fix outputs.tf first...this may not be needed
#data "external" "output" {
#  program = ["shell_command", "${path.module}/get_stack_output.sh "]
#
#  program = ["bash", "aws cloudformation describe-stacks --stack-name  \"${var.stackname}\" "]
#  query = {
# arbitrary map from strings to strings, passed
# to the external program as the data query.
#    stack-name = "${var.stackname}"
#  }
#}


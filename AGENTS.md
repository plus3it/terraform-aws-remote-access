# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This repository is a collection of Terraform modules that deploy remote access services on AWS, each from its own CloudFormation template. `guac` deploys an Apache Guacamole autoscaling group behind a public load balancer, `rdcb` deploys a standalone Remote Desktop Connection Broker and file server, `rdgw` deploys autoscaling Remote Desktop Gateways behind a public load balancer, and `rdsh` deploys autoscaling Remote Desktop Session Hosts behind an internal load balancer. Consumers reference a module by its subdirectory, such as `modules/rdgw`, and pass inputs named after the CloudFormation parameters; each module also creates a Route 53 record.

### Module-specific files

- `modules/<name>/` — One module each for `guac`, `rdcb`, `rdgw`, and `rdsh`, with `main.tf`, `variables.tf`, `versions.tf`, a `README.md`, and one `ra_*.template.cfn.yaml` CloudFormation template; `rdcb`, `rdgw`, and `rdsh` also have `outputs.tf` (`guac` has none)
- `psmodules/` — The `P3RemoteAccess` PowerShell module, which the `rdcb` and `rdsh` CloudFormation templates reference
- `scripts/` — PowerShell scripts that configure the RD Connection Broker, RD Gateway, and RD Session Host instances, `make-guac.sh` for the Guacamole instance, and `files/server.xml`; the CloudFormation templates refer to them by name or URL

### Deviations from the terraform-module profile

- There is no root module: the repository has no `main.tf`, `variables.tf`, or `outputs.tf` at the top level. The profile text about those files applies to each module under `modules/`.
- `tests/example_testcase/main.tf` is the only test case, and it sets `source = "../../"`, which points at the repository root, where no module exists. Check this path before relying on that test.
- The `rdcb`, `rdgw`, and `rdsh` modules deploy their CloudFormation template with `aws cloudformation deploy` from a `null_resource` provisioner, then read the stack back with a data source. Only `guac` uses an `aws_cloudformation_stack` resource.

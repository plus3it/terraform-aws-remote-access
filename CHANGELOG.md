## terraform-aws-remote-access Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### [0.9.0](https://github.com/plus3it/terraform-aws-tardigrade-ebs-encryption/releases/tag/0.9.0)

**Released**: 2025.12.30

**Summary**:

*   Addresses deprecation warning for aws_region "name" attribute

### 0.6.0

**Released**: 2020.04.10

**Commit Delta**: [Change from 0.5.2 release](https://github.com/plus3it/terraform-aws-remote-access/compare/0.5.2...0.6.0)

**Summary**:

*   Updates templates script references
*   Makes VpcId tf var required
*   Updates templates to utilize the cfn-lookup-ami-ids custom resource
*   Parameterizes AmiLookupLambdaArn

### 0.5.2

**Released**: 2020.04.06

**Commit Delta**: [Change from 0.1.0 release](https://github.com/plus3it/terraform-aws-remote-access/compare/0.1.0...0.5.2)

**Summary**:

*   Configures tls12 and .net crypto before remote downloads
*   Reestablishes bumpversion config for cfn templates

### 0.1.0

**Released**: 2020.02.28

**Commit Delta**: [Change from 0.0.1 release](https://github.com/plus3it/terraform-aws-remote-access/compare/0.0.1...0.1.0)

**Summary**:

*   YAML simplification
*   Installs patches as part of a new instance launch

### 0.0.1

**Released**: 2020.02.07

**Commit Delta**: [Change from 0.0.0 release](https://github.com/plus3it/terraform-aws-remote-access/compare/0.0.0...0.0.1)

**Summary**:

*   Forwards SSM Logs to CloudWatch.

### 0.0.0

**Commit Delta**: N/A

**Released**: 2019.11.07

**Summary**:

*   Initial release!

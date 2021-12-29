## terraform-aws-tardigrade-transit-gateway Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### 2.0.0

**Commit Delta**: [Change from 1.0.2 release](https://github.com/plus3it/terraform-aws-tardigrade-transit-gateway/compare/1.0.2..2.0.0)

**Released**: 2021.12.29

**Summary**:

*   Removes variables in cross-account-vpc-attachment module that were used to
    create a dependency so the attachment would succeed. These variables are no
    longer needed, presumably due to new retry functionality in the AWS provider.
*   Uses `configuration_aliases` instead of empty provider blocks.
*   Bumps minimum terraform version to 0.15 for the cross-account and cross-region
    modules.

### 0.0.0

**Commit Delta**: N/A

**Released**: 2019.11.13

**Summary**:

*   Initial release!

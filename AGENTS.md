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

This Terraform module creates an AWS EC2 Transit Gateway and, optionally, its route tables, routes, prefix list references, and VPC attachments. The gateway's settings are inputs such as `amazon_side_asn` and `description`, and the lists `route_tables`, `routes`, `prefix_list_references`, and `vpc_attachments` define what is added to it. Each list entry refers to route tables and attachments by the name of another entry or by the ID of an existing one. The module outputs `transit_gateway`, `vpc_attachments`, `route_tables`, `routes`, and `prefix_list_references`.

### Module-specific files

- `modules/route-table/` — Creates one Transit Gateway route table; called by the root module
- `modules/route/` — Creates one Transit Gateway route; called by the root module
- `modules/prefix-list-reference/` — Creates one Transit Gateway prefix list reference; called by the root module
- `modules/vpc-attachment/` — Creates a VPC attachment with its route table association, propagations, and VPC routes; called by the root module and by `cross-account-vpc-attachment`
- `modules/vpc-accepter/` — Accepts a VPC attachment and manages its route table association, propagations, and VPC routes; called by `cross-account-vpc-attachment`
- `modules/cross-account-vpc-attachment/` — Combines `vpc-attachment`, `vpc-accepter`, and `route` to set up an attachment between two accounts; consumers call it directly
- `modules/peering-attachment/` — Creates a peering attachment and its route table association; called by `cross-region-peering-attachment`
- `modules/peering-accepter/` — Accepts a peering attachment and creates its route table association; called by `cross-region-peering-attachment`
- `modules/cross-region-peering-attachment/` — Combines `peering-attachment` and `peering-accepter` to set up a peering between two regions; consumers call it directly

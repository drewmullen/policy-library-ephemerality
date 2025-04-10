# Sentinel policy checks for Emphemerality

This repo is a policy-as-code library for checking to see if your Terraform config contains resources or data sources that store secret values in state. It is designed to work with any and all providers at the same time. In order to avoid secrets in state these policies prefer [ephemerality](https://www.hashicorp.com/en/blog/ephemeral-values-in-terraform); that is [Ephemeral resources](https://developer.hashicorp.com/terraform/language/resources/ephemeral) and [write-only parameters](https://developer.hashicorp.com/terraform/language/resources/ephemeral/write-only).

Please note that if `terraform_version` is less than 1.11 the checks will pass

During execution this policy downloads a list resources from the same repo ([here](https://github.com/drewmullen/policy-library-ephemerality/tree/main/data)). The goal is to keep this list as up to date as possible by using daily CI runs to check for new ephemeral or resources with write-only fields. As a rule, this repo will never remove a resource from the generated list and will only add new. If you would like to keep the lists static, please fork this repo and update the [import statements](https://github.com/drewmullen/policy-library-ephemerality/blob/main/sentinel.hcl#L2,L12) to your preferred location (perhaps your fork). 

For more details on how these lists are generated see [below](https://github.com/drewmullen/policy-library-ephemerality/blob/main/README.md#which-resources--data-sources-are-checked).

## TL;DR How can I use this?

Great question! Although there are many ways to set sentinel policies to your HCP TF Org, heres what I would do:
1. create a new repo for policies at an enforcement level (suggested: `policies-soft-mandatory`)
2. go to the latest version of the [public policy version](https://registry.terraform.io/policies/drewmullen/ephemerality)
3. go to the "usage instructions" section, click both policies, copy the code
4. add the code to your repo and push
5. create a policy set in your TFC org using the `tfe_` provider

Example of using tfe provider:
```hcl
resource "tfe_policy_set" "ephemerality" {
  agent_enabled       = true
  global              = true
  kind                = "sentinel"
  name                = "ephemerality"
  organization        = <your org>
  overridable         = true
  policy_tool_version = "latest"
  vcs_repo {
    github_app_installation_id = "ghain-<your github app id>"
    identifier                 = "<your gh org>/<your gh policy repo name>"
    ingress_submodules         = false
  }
}
```

## Which resources / data sources are checked?

Ephemerality in Terraform is a relatively new feature. As such, not all providers support this functionality yet and coverage across any given provider is still growing and evolving.

In order to check the relevent terraform resources we have both lists of generated (scraped) resources and also a manual list resource check. Most of the data/resources that we want to scan for can be easily [generated](https://github.com/drewmullen/policy-library-ephemerality/blob/main/generators/ephemeral_resources/README.md?plain=1#L7) from any providers schema. However, there are some [circumstances](https://github.com/drewmullen/policy-library-ephemerality/issues/3) where we cannot generate a list of resources that we want to scan for.

Regarding resource generators, more info can be found [here](https://github.com/drewmullen/policy-library-ephemerality/tree/main/generators/ephemeral_resources)

For each policy the list of resources to check are fetched from this git repo. Override params are available in some cirucmstances.

### Policies

- **ephemerals-retrieves**: This is a list of any `ephemeral` resource schemas presented by a provider. We scan several providers for any listed ephemeral resources, drop the json payload in [data](https://github.com/drewmullen/policy-library-ephemerality/tree/main/data). This list is then compared to **data sources** in a terraform config. If a user is using a data source whos type matches the name of an available ephemeral resource, the policy check fails. 
- **write-only**: This is a map of resources in all [monitored providers](https://github.com/drewmullen/policy-library-ephemerality/blob/main/generators/ephemeral_resources/providers.tf#L3-L19) that have a parameter that ends in `_wo`. The name of the resource is the key in the map and the value is the full name of the `_wo` parameter. During policy check, if a user is using a resource type from the map and **not** also using the associated `_wo` parameter, the check fails. **Note that we only scan the root of the resource schemas**. At the time of writing this there is no examples where wo attributes are deeper nested than the root.
- **ephemeral-creates**: This is a manually generated list of resources that have a corresponding ephemeral resource but it is designed to replace a resource (not a data source). Please open PRs to update this list! There is an override param `filtered_resources` if you need to immediately update your policy. More details can be found [here](https://github.com/drewmullen/policy-library-ephemerality/issues/3).


## Updating the list of ephemeral resources

Soon™ the generators will be updated to run daily. Since the resources are remotely retrieved, this repos commitment is to _never_ remove a entry from a list once we release 1.0.

If there are ephemeral resources that are not included in this data set (yet) it is likely for 1 of 2 reasons:
1. We are not referencing a provider you wish (see [here](https://github.com/drewmullen/policy-library-tfe-terraform/blob/main/generators/ephemeral_resources/providers.tf))
1. We have not run the generator to grab the latest provider schema (see [here](https://github.com/drewmullen/policy-library-tfe-terraform/tree/main/data))

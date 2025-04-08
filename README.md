# Sentinel Policy checks for Emphemerality

This repo is a policy-as-code library for checking to see if your Terraform config contains resources or data sources that store secret values in state. In order to avoid secrets in state these policies prefer [ephemerality](https://www.hashicorp.com/en/blog/ephemeral-values-in-terraform); that is [Ephemeral resources](https://developer.hashicorp.com/terraform/language/resources/ephemeral) and [write-only parameters](https://developer.hashicorp.com/terraform/language/resources/ephemeral/write-only).

Please note that if `terraform_version` is less than 1.11 the checks will pass

## How can I use this?

Great question! Although there are many ways to set sentinel policies to your HCP TF Org, heres what I would do:
1. create a new repo for policies at an enforcement level (suggested: `policies-soft-mandatory`)
2. go to the latest version of the [public policy version](https://registry.terraform.io/policies/drewmullen/ephemerality/0.0.2)
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

Ephemerality in Terraform is a relatively new feature. As such, not all providers support this functionality yet and coverage across any given provider may be incomplete. 

The logic in these policies are quite simple. We generate and reference a list ephemeral resources from several popular tf providers, we then assume the names of the ephemeral resources correspond to a data source, and ensure those data sources arent utilized in a given Terraform config. 

The generated list is dumped to a json payload which the policy itself downloads from the public internet per run. This allows us to maintain the list in a public GitHub repo (and update it periodically) without requiring users to update their policy.

With write-only capable resources we do something similar except we search for resource schemas that have an attribute that does not start with `has_` but ends with `_wo` and we form another json payload thats used to compare. We do assume that any `wo` attributes occur at the root of the schema, if there is ever a resource with a write-only attribute nested deeper than the schema root, we will have to adjust - as of today, im not aware of any.

## Updating the list of ephemeral resources

If there are ephemeral resources that are not included in this data set (yet) it is likely for 1 of 2 reasons:
1. We are not referencing a provider you wish (see [here](https://github.com/drewmullen/policy-library-tfe-terraform/blob/main/generators/ephemeral_resources/providers.tf))
1. We have not run the generator to grab the latest provider schema (see [here](https://github.com/drewmullen/policy-library-tfe-terraform/tree/main/data))


## Other ideas we've considered but would like feedback on

1. Is there a use case here to accept a parameter to define this set of resources to check?
1. Is there a use case to accept an optional parameter to append to the list of ephemeral resources checked?
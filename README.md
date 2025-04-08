# Sentinel Policy Set for Emphemerality

This repo is a policy-as-code library for checking to see if your Terraform config contains resources or data sources that store secret values in state. In order to avoid secrets in state these policies prefer [ephemerality](https://www.hashicorp.com/en/blog/ephemeral-values-in-terraform); that is [Ephemeral resources](https://developer.hashicorp.com/terraform/language/resources/ephemeral) and [write-only parameters](https://developer.hashicorp.com/terraform/language/resources/ephemeral/write-only).

## Which resources / data sources are checked?

Ephemerality in Terraform is a relatively new feature. As such, not all providers support this functionality yet and coverage across any given provider may be incomplete. 

The logic in these policies are quite simple. We generate and reference a list ephemeral resources from several popular tf providers, we then assume the names of the ephemeral resources correspond to a data source, and ensure those data sources arent utilized in a given Terraform config. 

The generated list is dumped to a json payload which the policy itself downloads from the public internet per run. This allows us to maintain the list in a public GitHub repo (and update it periodically) without requiring users to update their policy.

With write-only capable resources we do something similar except we search for resource schemas that have an attribute that does not start with `has_` but ends with `_wo` and we form another json payload thats used to compare.

## Updating the list of ephemeral resources

If there are ephemeral resources that are not included in this data set (yet) it is likely for 1 of 2 reasons:
1. We are not referencing a provider you wish (see here)
1. We have not run the generator to grab the latest provider schema (see here)


## Other ideas we've considered but would like feedback on

1. Is there a use case here to accept a parameter to define this set of resources to check?
1. Is there a use case to accept an optional parameter to append to the list of ephemeral resources checked?
# Prefer Write-Only Resource Attributes

| Provider | Category |
|----------|----------|
| Multiple Providers | Security |

## Description

This policy checks if resources with write-only attribute options are using them.

This policy checks for resources that have write-only attribute options available but are not using them. Write-only attributes are a security feature that allows sensitive values to be set in a resource without storing them in the Terraform state file.

The policy compares the resources in your Terraform configuration against a list of resources that have write-only attribute options available. For each resource that has a write-only option, the policy checks if that option is being used.

The policy will fail if it finds resources in your configuration that have write-only attribute options available but are not using them.

Note that if the Terraform version detected in your configuration is less than 1.11, the check will pass automatically. This is because write-only attributes were introduced in Terraform 1.11.


This policy is implemented in the [prefer-write-only-resource-attributes.sentinel](https://github.com/drewmullen/policy-library-ephemerality/blob/main/prefer-write-only-resource-attributes.sentinel) file.

## Policy Results (Pass)

```bash
  trace:
    prefer-write-only-resource-attributes.sentinel:27:1 - Rule "main"
      Description:
        A new write only attribute available for managed resources used,
        please use those instead

      Value:
        false

    prefer-write-only-resource-attributes.sentinel:21:1 - Rule "rule_against_resources_with_wo_not_set"
      Value:
        false
```

## Policy Results (Fail)

```bash
trace:
  prefer-write-only-resource-attributes.sentinel:27:1 - Rule "main"
    Description:
      A new write only attribute available for managed resources used,
      please use those instead

    Value:
      true

  prefer-write-only-resource-attributes.sentinel:21:1 - Rule "rule_against_resources_with_wo_not_set"
    Value:
      true
```

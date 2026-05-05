# Prefer Write-Only Resource Attributes

| Provider | Category |
|----------|----------|
| Multiple Providers | Security |

## Description

This policy checks if resources with write-only attribute options are using them.

Write-only attributes are a security feature that allows sensitive values to be set in a resource without storing them in the Terraform state file. The policy compares the resources in your Terraform configuration against a list of known resources that have write-only attribute options and fails if any of those resources are configured without using at least one write-only attribute.

Some resources expose more than one write-only attribute (for example, `tfe_notification_configuration` has both `token_wo` and `url_wo`). The policy passes as long as at least one write-only attribute is present in the resource configuration.

Note that if the Terraform version detected in your configuration is less than 1.11, the check will pass automatically. This is because write-only attributes were introduced in Terraform 1.11.

This policy is implemented in the [prefer-write-only-resource-attributes.sentinel](https://github.com/drewmullen/policy-library-ephemerality/blob/main/prefer-write-only-resource-attributes.sentinel) file.

## Test Cases

| Test File | Config | Expected |
|-----------|--------|----------|
| `fail.hcl` | `aws_ssm_parameter` using `value` (non-WO) | Fail |
| `success.hcl` | `aws_ssm_parameter` using `value_wo` | Pass |
| `success-version-too-low.hcl` | `aws_ssm_parameter` using `value`, Terraform < 1.11 | Pass |
| `fail-multi-wo.hcl` | `tfe_notification_configuration` using neither `token_wo` nor `url_wo` | Fail |
| `success-multi-wo-partial.hcl` | `tfe_notification_configuration` using `token_wo` only | Pass |
| `success-multi-wo-all.hcl` | `tfe_notification_configuration` using both `token_wo` and `url_wo` | Pass |

## Policy Results (Pass)

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

## Policy Results (Fail)

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

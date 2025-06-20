# Prefer Ephemeral Resources for Creation

| Provider | Category |
|----------|----------|
| Multiple Providers | Security |

## Description

This policy checks if resources that store secret values in state are using ephemeral resources instead.

This policy checks for resources that store secret values in state. It compares the resources in your Terraform configuration against a list of resources that have ephemeral alternatives available for creation operations.

When a resource has an ephemeral alternative available, you should use the ephemeral resource instead to avoid storing sensitive data in the Terraform state file. Ephemeral resources are designed to handle sensitive data more securely by not persisting it in state.

The policy will fail if it finds resources in your configuration that have ephemeral alternatives available but are not using them.

Note that if the Terraform version detected in your configuration is less than 1.11, the check will pass automatically. This is because ephemeral resources were introduced in Terraform 1.11.


This policy is implemented in the [prefer-ephemeral-creates.sentinel](https://github.com/drewmullen/policy-library-ephemerality/blob/main/prefer-ephemeral-creates.sentinel) file.

## Policy Results (Pass)

```bash
  trace:
    prefer-ephemeral-creates.sentinel:30:1 - Rule "main"
      Description:
        Please avoid using resources that store secret values in
        state, use ephemeral resources instead

      Value:
        true

    prefer-ephemeral-creates.sentinel:25:1 - Rule "rule_against_secret_bearing_resources"
      Value:
        true
```

## Policy Results (Fail)

```bash
    trace:
      prefer-ephemeral-creates.sentinel:30:1 - Rule "main"
        Description:
          Please avoid using resources that store secret values in
          state, use ephemeral resources instead

        Value:
          false

      prefer-ephemeral-creates.sentinel:25:1 - Rule "rule_against_secret_bearing_resources"
        Value:
          false
```

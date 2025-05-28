# Prefer Ephemeral Resources for Data Retrieval

| Provider | Category |
|----------|----------|
| Multiple Providers | Security |

## Description

This policy checks if data sources that retrieve secret values are using ephemeral alternatives.

This policy checks for data sources that retrieve secret values and store them in state. It compares the data sources in your Terraform configuration against a list of data sources that have ephemeral alternatives available.

When a data source has an ephemeral alternative available, you should use the ephemeral data source instead to avoid storing sensitive data in the Terraform state file. Ephemeral data sources are designed to handle sensitive data more securely by not persisting it in state.

The policy will fail if it finds data sources in your configuration that have ephemeral alternatives available but are not using them.

Note that if the Terraform version detected in your configuration is less than 1.11, the check will pass automatically. This is because ephemeral data sources were introduced in Terraform 1.11.


This policy is implemented in the [prefer-ephemeral-retrieves.sentinel](https://github.com/drewmullen/policy-library-ephemerality/blob/main/prefer-ephemeral-retrieves.sentinel) file.

## Policy Results (Pass)

```bash
trace:
  prefer-ephemeral-retrieves.sentinel:24:1 - Rule "main"
    Description:
      Please avoid using the data sources that store secret values in
      state, use ephemeral values instead

    Value:
      true

  prefer-ephemeral-retrieves.sentinel:19:1 - Rule "rule_against_secret_bearing_datasources"
    Value:
      true
```

## Policy Results (Fail)

```bash
trace:
  prefer-ephemeral-retrieves.sentinel:24:1 - Rule "main"
    Description:
      Please avoid using the data sources that store secret values in
      state, use ephemeral values instead

    Value:
      false

  prefer-ephemeral-retrieves.sentinel:19:1 - Rule "rule_against_secret_bearing_datasources"
    Value:
      false
```

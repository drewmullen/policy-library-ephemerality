# Generate List of Provider Ephemeral Resources

You can generate a list of ephemeral resources, as defined various providers.

```shell
terraform init
terraform providers schema -json | jq '
{
  "ephemeral": [
    .provider_schemas | 
    to_entries[] as $provider |
    $provider.value.ephemeral_resource_schemas? |
    select(.) |
    to_entries[] |
    select(
      (.value.block.deprecated? != true) and
      ((.value.block.description? // "" | test("deprecated|obsolete|removed"; "i")) | not)
    ) |
    .key
  ]
}' > ../../data/raw/ephemeral.json
```

## Generate list for write-only resources

```shell
terraform providers schema -json | jq '
  {
    "write_only": (
      .provider_schemas | to_entries | map(
        .value.resource_schemas | to_entries | map(
          select(.value.block.attributes != null) | 
          select(.value.block.attributes | to_entries | map(.value) | any(.write_only == true))
        ) | map({
          key: .key,
          value: (.value.block.attributes | to_entries | map(select(.value.write_only == true)) | map(.key)[])
        })
      ) | flatten | map({key: .key, value: .value}) | from_entries
    )
  }
'  > ../../data/raw/write_only.json
```

## Add new providers

The above code scrapes an arbitrary list of Terraform Providers for all published ephemeral resources. To add more providers to scrape from please:
1. update [here]()
1. run the commands from the top of this document
1. submit a PR
1. profit
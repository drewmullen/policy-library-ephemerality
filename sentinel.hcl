import "static" "ephemeral-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/schema_ephemerals.json"
    format = "json"
}

import "static" "wo-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/write_only.json"
    format = "json"
}

policy "prefer-ephemeral-resources" {
    source = "./prefer-ephemeral-resources.sentinel"
    enforcement_level = "soft-mandatory"
}

policy "prefer-write-only-resource-attributes" {
    source = "./prefer-write-only-resource-attributes.sentinel"
    enforcement_level = "soft-mandatory"
}
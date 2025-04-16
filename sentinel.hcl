import "static" "ephemeral-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/ephemeral/gen_schema_ephemerals.json"
    format = "json"
}

import "static" "manual-resource-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/ephemeral/manual_resources.json"
    format = "json"
}

import "static" "wo-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/write-only/gen_write_only.json"
    format = "json"
}

policy "prefer-ephemeral-retrieves" {
    source = "./prefer-ephemeral-retrieves.sentinel"
    enforcement_level = "soft-mandatory"
}

policy "prefer-ephemeral-creates" {
    source = "./prefer-ephemeral-creates.sentinel"
    enforcement_level = "soft-mandatory"
}

policy "prefer-write-only-resource-attributes" {
    source = "./prefer-write-only-resource-attributes.sentinel"
    enforcement_level = "soft-mandatory"
}

policy "aws-ssm" {
    source = "./aws-ssm.sentinel"
    enforcement_level = "soft-mandatory"
}

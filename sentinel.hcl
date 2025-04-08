import "static" "ephemeral-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/schema_ephemerals.json"
    format = "json"
}

import "static" "wo-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/write_only.json"
    format = "json"
}

import "module" "common-functions" {
    source = "https://raw.githubusercontent.com/jweigand/remote-sentinel-source/refs/heads/main/modules/common-functions.sentinel"
}

policy "prefer-ephemeral-resources" {
    source = "./prefer-ephemeral-resources.sentinel"
    enforcement_level = "advisory"
}
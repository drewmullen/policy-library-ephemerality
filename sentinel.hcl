import "static" "ephemeral-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/ephemerality.json"
    format = "json"
}

policy "prefer-ephemeral-retrieves" {
    source = "./prefer-ephemeral-retrieves.sentinel"
    enforcement_level = "advisory"
}

policy "prefer-ephemeral-creates" {
    source = "./prefer-ephemeral-creates.sentinel"
    enforcement_level = "advisory"
}

policy "prefer-write-only-resource-attributes" {
    source = "./prefer-write-only-resource-attributes.sentinel"
    enforcement_level = "advisory"
}

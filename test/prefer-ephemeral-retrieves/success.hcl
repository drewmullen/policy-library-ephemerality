import "static" "ephemeral-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/ephemeral/gen_schema_ephemerals.json"
    format = "json"
}

mock "tfconfig/v2" {
    module {
        source = "./testdata/tfconfig-success.sentinel"
    }
}

mock "tfplan/v2" {
    module {
        source = "./testdata/tfplan-above.sentinel"
    }
}

test {
    rules  = {
        main = true
    }
}

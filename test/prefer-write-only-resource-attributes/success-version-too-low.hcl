import "static" "wo-schema-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/write-only/gen_write_only.json"
    format = "json"
}

mock "tfconfig/v2" {
    module {
        source = "./testdata/tfconfig-success.sentinel"
    }
}

mock "tfplan/v2" {
    module {
        source = "./testdata/tfplan-low.sentinel"
    }
}

test {
    rules  = {
        main = true
    }
}
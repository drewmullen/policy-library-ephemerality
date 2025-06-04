import "static" "ephemeral-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-ephemerality/refs/heads/main/data/ephemerality.json"
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

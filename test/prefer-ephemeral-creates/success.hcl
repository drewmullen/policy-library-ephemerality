import "static" "manual-resource-data" {
    source = "../../data/ephemeral/manual_resources.json"
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

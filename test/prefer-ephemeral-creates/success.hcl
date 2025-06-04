import "static" "ephemeral-data" {
    source = "../../data/ephemerality.json"
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

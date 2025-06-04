import "static" "ephemeral-data" {
    source = "../../data/ephemerality.json"
    format = "json"
}

mock "tfconfig/v2" {
    module {
        source = "./testdata/tfconfig-fail.sentinel"
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

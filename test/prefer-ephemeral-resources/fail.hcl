import "static" "remote-data" {
    source = "https://raw.githubusercontent.com/drewmullen/policy-library-tfe-terraform/refs/heads/main/data/schema_ephemerals.json"
    format = "json"
}

import "module" "common-functions" {
    source = "https://raw.githubusercontent.com/jweigand/remote-sentinel-source/refs/heads/main/modules/common-functions.sentinel"
}

mock "tfconfig/v2" {
    module {
        source = "./testdata/tfconfig-fail.sentinel"
    }
}

test {
    rules  = {
        main = false
    }
}
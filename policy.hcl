path "azure/creds/contributor" {
    capabilities = ["read",  "delete"]
}

path "secret/data/azure/environment" {
    capabilities = ["read"]
}

path "tfc/creds/ci-user" {
  capabilities = ["read","delete"]
}

path "leases/*" {
  capabilities = ["read","delete","update","list","create"]
}
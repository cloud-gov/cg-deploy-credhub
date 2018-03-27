## CredHub secrets schema

Common secrets store in CredHub for cloud.gov

### Design
1. All secrets are stored in a single, HA, CredHub bosh deployment deployed by `master-bosh`.
1. Secrets are namespaced by `/<DIRECTOR>/<DEPLOYMENT>/` to [integrate with bosh config server](https://github.com/cloudfoundry-incubator/credhub/blob/master/docs/bosh-config-server.md).
    1. `common` and `master-bosh/masterbosh` are _manually_ populated to bootstrap `master-bosh` director.
    1. Manifests deployed by a bosh director should interpolate with `((secret)))` for things which belong to that deployment. Anything pulled in from another deployment must use `((/absolute/path/to/secret))`
1. Secrets are either `user`, `value`, `certificate`, or `rsa` [types](https://github.com/cloudfoundry-incubator/credhub/blob/master/docs/credential-types.md). Attributes are referenced as `((secret.attribute))`: ex `((/common/ca_cert.certificate))`
1. Concourse uses the same common CredHub for [credential management](https://concourse-ci.org/creds.html#credhub)
    1. This will require Concourse to accept absolute paths for interpolation in pipelines (It might not currently support this).
1. Existing secrets should be _manually_ loaded into CredHub to initialize the store, and rotation performed _manually_ until we can test dependencies in automatically generated credentials (common ca signed certs, public_key and cert with same private_key, etc.)

### Manifest changes
1. `cg-deploy-bosh` will need to name directors uniquely in [`cg-deployment.yml`](https://github.com/18F/cg-deploy-bosh/blob/master/bosh-deployment.yml#L174)
    1. bosh (director) certificates will probably need to replaced so names on certs match the unique director names.
1. Remaining `cg-deploy-bosh` merged secrets + yaml in `*-bosh-*.yml` will need to migrate to CredHub, terraform, or public manifests.
1. Remaining `cg-deploy-concourse` merged secrets + yaml in `concourse-tooling-*.yml` will need to migrate to CredHub, terraform, or public manifests.
1. Remaining `cg-deploy-powerdns` merged secrets + yaml in `*-pdns*.yml` will need to migrate to CredHub, terraform, or public manifests.
1. `cg-deploy-prometheus` secrets accessed as varsfile `*-prometheus.yml` will need to migrate to CredHub, terraform, or public manifests.
1. Remaining `cg-deploy-nessus-manager` merged secrets + yaml in `nessus-manager.*.yml` will need to migrate to CredHub, terraform, or public manifests.


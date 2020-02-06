# nordmart-dev-tools
A repository to install tools required by [nordmart dev applications](https://github.com/stakater-lab/nordmart-dev-apps)


Nordmart is a set of microservices that represent an online shopping mart. Currently, there are two options for deploying
apps that are by using istio or using ingresses for networking. 

## Install from local machine

### With Flux
**Flux:** You define the entire desired state of your cluster in git and flux ensures that the current state matches the one declared in repo.

1. Fork/Duplicate [nordmart-dev-apps](https://github.com/stakater-lab/nordmart-dev-apps) and [nordmart-dev-tools](https://github.com/stakater-lab/nordmart-dev-tools)
2. Replace all configuration parameters with corresponding values in nordmart-dev-apps & nordmart-dev-tools
4. Deploying nordmart-dev-tools & nordmart-dev-apps
    a. For without istio, run `make install`. 
    b. For istio, run `make install-istio`
5. If you want flux to deploy everything from `nordmart-dev-apps` repository. Add flux public key to that repo.
`kubectl -n nordmart-dev-tools logs deployment/nordmart-dev-flux | grep identity.pub | cut -d '"' -f2`

### Without Flux

1. Fork/Duplicate [nordmart-dev-apps](https://github.com/stakater-lab/nordmart-dev-apps) and [nordmart-dev-tools](https://github.com/stakater-lab/nordmart-dev-tools)
2. Replace all configuration parameters with corresponding values in nordmart-dev-apps & nordmart-dev-tools
3. run `make install-local` or `make install-local-istio` for istio in nordmart-dev-tools
4. run `make install-local` or `make install-local-istio` for istio in nordmart-dev-apps

## Uninstall

Run `make delete` or `make delete-istio` if you used istio to remove nordmart-dev-tools from your cluster.

## Configuration Parameters

| Parameter | Details | Required |
|---|---|
| DOMAIN | It will be used to create ingress for the application. It need to be changed in `releases/web-helm-release.yaml`, `releases/docker-cfg-secret.yaml` and `releases/gateway-helm-release.yaml` manifest |  Mandatory |
| STAKATER_NORDMART_DEV_APPS_SSH_GIT_URL | SSH URL for your nordmart-dev-apps Github repo. `nil`<br>(e.g `git@github.com/stakater-lab/nordmart-dev-apps.git`. Notice `:` is replaced with `/` in the URL ) | Mandatory|
| STAKATER_NORDMART_DEV_APPS_PLATFORM_BRANCH | Branch to use for `STAKATER_NORDMART_DEV_APPS_PLATFORM_BRANCH` | Mandatory|
| DNS_PROVIDER | Cloud DNS Provider, example `aws` | Required if using istio|
| AWS_ACCESS_KEY_ID | AWS Access Key Id having access to create/delete/update Route53 HostedZone entries| Required if using istio|
| AWS_SECRET_ACCESS_KEY | AWS Secret Access Key having access to create/delete/update Route53 HostedZone entries| Required if using istio|
| STORAGE_CLASS_NAME | Required to create PVC | Required|
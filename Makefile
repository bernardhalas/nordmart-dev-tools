.ONESHELL:
SHELL := /bin/bash

### Without istio

create-namespace:
	kubectl apply tools/namespaces -f .

delete-namespace:
	kubectl delete tools/namespaces -f .

install-local:
	kubectl apply tools/namespaces -f .

install-flux-dry-run:
	cd tools
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply --dry-run -f rbac-flux.yaml
	kubectl apply --dry-run -f flux.yaml

install-flux:
	cd tools
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply -f rbac-flux.yaml
	kubectl apply -f flux.yaml

delete-flux:
	cd tools
	kubectl delete -f flux.yaml
	kubectl delete -f rbac-flux.yaml

install: create-namespace install-flux

install-dry-run: install-flux-dry-run

delete: delete-flux delete-namespace

### With Istio

create-namespace-istio:
	kubectl apply tools-istio/namespaces -f .

delete-namespace-istio:
	kubectl delete tools-istio/namespaces -f .

install-local-istio:
	kubectl apply tools-istio/namespaces -f .
	kubectl apply tools-istio/secrets -f .
	kubectl apply -f tools-istio/external-dns.yaml

install-flux-dry-run-istio:
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply --dry-run -f tools-istio/rbac-flux.yaml
	kubectl apply --dry-run -f tools-istio/flux.yaml

install-flux-istio:
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply -f tools-istio/rbac-flux.yaml
	kubectl apply -f tools-istio/flux.yaml

delete-flux-istio:
	kubectl delete -f tools-istio/flux.yaml
	kubectl delete -f tools-istio/rbac-flux.yaml

install-external-dns:
	kubectl apply -f tools-istio/secrets/secret-external-dns.yaml
	kubectl apply -f tools-istio/external-dns.yaml

delete-external-dns:
	kubectl delete -f tools-istio/secrets/secret-external-dns.yaml
	kubectl delete -f tools-istio/external-dns.yaml

install-istio: create-namespace-istio install-flux-istio install-external-dns

install-dry-run-istio: install-flux-dry-run-istio

delete-istio: delete-flux-istio delete-external-dns delete-namespace-istio

.PHONY: install install-dry-run

.ONESHELL:
SHELL := /bin/bash
NAMESPACE ?= nordmart-dev-apps

create-namespace:
	kubectl create namespace $(NAMESPACE) || true

install-flux-dry-run:
	cd tools
	kubectl apply --dry-run -f rbac-flux.yaml
	helm repo add weaveworks https://weaveworks.github.io/flux
	helm repo update
	helm upgrade --dry-run --install flux-nordmart-dev --namespace $(NAMESPACE) weaveworks/flux -f flux-values.yaml

install-flux:
	cd tools
	kubectl apply -f rbac-flux.yaml
	helm repo add weaveworks https://weaveworks.github.io/flux
	helm repo update
	helm upgrade --install flux-nordmart-dev --namespace $(NAMESPACE) weaveworks/flux -f flux-values.yaml

install: create-namespace install-flux

install-dry-run: install-flux-dry-run

.PHONY: install install-dry-run
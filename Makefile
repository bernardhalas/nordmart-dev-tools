.ONESHELL:
SHELL := /bin/bash
NAMESPACE ?= nordmart-dev-apps

create-namespace:
	kubectl create namespace $(NAMESPACE) || true

install-flux-dry-run:
	cd dev
	kubectl apply --dry-run -f rbac-flux.yaml
	helm upgrade --dry-run --install flux-nordmart-dev --namespace $(NAMESPACE) weaveworks/flux -f flux-values.yaml

install-flux:
	cd dev
	kubectl apply -f rbac-flux.yaml
	helm upgrade --install flux-nordmart-dev --namespace $(NAMESPACE) weaveworks/flux -f flux-values.yaml

install-secret-dry-run:
	cd dev
	kubectl apply --dry-run -f secret.yaml

install-secret:
	cd dev
	kubectl apply -f secret.yaml

install: create-namespace install-flux install-secret

install-dry-run: install-flux-dry-run install-secret-dry-run

.PHONY: install install-dry-run
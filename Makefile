.ONESHELL:
SHELL := /bin/bash
NAMESPACE ?= nordmart-dev-apps

create-namespace:
	kubectl create namespace $(NAMESPACE) || true
	kubectl label namespace $(NAMESPACE) istio-injection=enabled || true

install-flux-dry-run:
	cd tools
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply --dry-run -f rbac-flux.yaml -n $(NAMESPACE)
	kubectl apply --dry-run -f flux.yaml -n $(NAMESPACE)

install-flux:
	cd tools
	helm init --client-only
	helm repo add fluxcd https://fluxcd.github.io/flux
	helm repo update
	kubectl apply -f rbac-flux.yaml -n $(NAMESPACE)
	kubectl apply -f flux.yaml -n $(NAMESPACE)

delete-flux:
	cd tools
	kubectl delete -f flux.yaml -n -n $(NAMESPACE)
	kubectl delete -f rbac-flux.yaml

install: create-namespace install-flux

install-dry-run: install-flux-dry-run

delete: delete-flux

.PHONY: install install-dry-run

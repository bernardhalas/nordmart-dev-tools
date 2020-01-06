.ONESHELL:
SHELL := /bin/bash

create-namespace:
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

delete: delete-flux

.PHONY: install install-dry-run

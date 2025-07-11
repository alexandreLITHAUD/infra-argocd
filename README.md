# Infra - ArgpoCD

This repo contains the files in order to deploy an argocd cluster easily using helmfile.

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)
- [helmfile](https://github.com/roboll/helmfile)
- [helm-secrets](https://github.com/jkroepke/helm-secrets)
- [sops](https://github.com/mozilla/sops)

## Install tools

sops : brew install sops
helm : brew install helm
helmfile : brew install helmfile
helm-secrets : helm plugin install https://github.com/jkroepke/helm-secrets --version v4.6.5

## Sops and Age configuration

Do the following:

```bash
age-keygen -o key.txt
```

Add your public key to `~/.sops.yaml` file:

Also do not forget to export the environment variable `SOPS_AGE_KEY_FILE`:

```bash
export SOPS_AGE_KEY_FILE=$(pwd)/key.txt
```

## Usage

Run the following command to deploy the argocd cluster in the default environment:

```bash
helmfile apply -e default
```

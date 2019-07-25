#!/usr/bin/env bash

kubectl apply -f helm/mac-storage.yaml

helm --debug=true install --name=vscode --values=helm/vscode/values.yaml helm/vscode
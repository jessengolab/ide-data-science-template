#!/usr/bin/env bash
helm delete --purge vscode
kubectl delete pvc vscode-code-vscode-0
kubectl delete pvc vscode-data-vscode-0


#!/bin/bash
###############################################################################
# This script will deploy Otel Operater and Collectors to the current K8s
# context. 
# 
# Ensure the following environment vaiables are set properly before running
# CHRONOSPHERE_ORG_NAME
# CHRONOSPHERE_API_TOKEN
###############################################################################
if [[ -z ${CHRONOSPHERE_ORG_NAME+x} ]]; then
    echo "CHRONOSPHERE_ORG_NAME is not set" && exit 1
elif [[ -z ${CHRONOSPHERE_API_TOKEN+x} ]]; then
    echo "CHRONOSPHERE_API_TOKEN is not set" && exit 1
fi
set -x #echo on
cd "$(dirname "$0")"
kubectl create namespace collectors
# otel-collector deployed using helm is not managed by otel operator
# to deploy an otel-collector managed by the operator, deploy a kind of "OpenTelemetryCollector"
kubectl -n collectors create secret generic chronosphere-secret --from-literal=api-token="$CHRONOSPHERE_API_TOKEN" --from-literal=org="$CHRONOSPHERE_ORG_NAME"
helm upgrade --install otel-collector open-telemetry/opentelemetry-collector \
  --values otel-collector-values.yaml \
  --namespace collectors \
  --version 0.90.1
sleep 10
kubectl -n collectors get pods
# For the API server to communicate with the webhook component, the webhook requires a TLS certificate that 
# the API server is configured to trust. The easiest and default method is to install the cert-manager.
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.0/cert-manager.yaml
# Wait for all cert-manager resource to be up and running
sleep 90
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update open-telemetry 
# Use an automatically generated self-signed TLS certificate by setting admissionWebhooks.certManager.enabled
# to false and admissionWebhooks.autoGenerateCert to true (default)
helm upgrade --install otel-operator open-telemetry/opentelemetry-operator  \
  --set admissionWebhooks.certManager.enabled=false \
  --set manager.collectorImage.repository="otel/opentelemetry-collector-contrib" \
  --set manager.extraArgs={"--enable-go-instrumentation"} \
  --namespace collectors \
  --version 0.63.0
sleep 5
kubectl -n collectors get all

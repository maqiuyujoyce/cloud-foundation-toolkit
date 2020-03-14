#!/bin/bash

while [[ $# -gt 0 ]]; do
  case "${1}" in
    --source-directory) SRC_DIR="${2:-}"; shift ;;
    *)                   echo "Unrecognized command line parameter: $1"; exit 1 ;;
  esac
  shift
done

echo "======Configuring the placeholders and running the tests...======"

# TODO: Get values from file and move the logic below back to the kpt-test.sh.

kpt cfg set $SRC_DIR project-id maqiuyu-tf-iam --set-by=testing
kubectl apply -f $SRC_DIR

echo "======Verifiying that all the resources are ready...======"
kubectl wait --for=condition=ready -f $SRC_DIR --timeout=60s

echo "======Cleaning up the resources...======"
kubectl delete -f $SRC_DIR
kpt cfg set $SRC_DIR project-id \${PROJECT_ID?} --set-by=PLACEHOLDER
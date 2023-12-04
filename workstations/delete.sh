#!/bin/bash

for i in {1..66}; do
    gcloud workstations delete --quiet user$i --cluster=next23-sandbox-cluster --config=next23-sandbox-config --region=us-central1
done

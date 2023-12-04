#!/bin/bash

for i in {2..66}; do
    gcloud workstations create user$i --cluster=next23-sandbox-cluster --config=next23-sandbox-config --region=us-central1
done

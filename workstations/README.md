# Workstations sandbox

This directory contains the container image instructions/source files for a Cloud Workstation sandbox hosting the Cymbal Superstore demo. 

**NOTE** - These instructions are not needed if you're setting up one Workstation for yourself to use Duet AI. It's only needed if you need a *fleet* of workstations (eg. 60 machines for a workshop) and you want to bake the Cymbal Superstore demo code, and Duet AI settings, into the workstations without manually logging into each one. 

### How to build: 

```
docker build --platform=linux/amd64 -t gcr.io/cymbal-superstore-next23/workstation:latest .
docker push gcr.io/cymbal-superstore-next23/workstation:latest
```

### Setting up a workstation
1. Start and launch workstation 
2. Sign in to GCP with assigned user 
3. Set project

```
gcloud config set project cymbal-superstore-next23
```

4. Edit cloud code USER settings json: 

```
{
    "cloudcode.duetAI.project": "cymbal-superstore-next23",
    "cloudcode.updateChannel": "trusted-testers",
    "cloudcode.project": "cymbal-superstore-next23"
}
```
5. Reload cloud code when prompted 
6. Open Terminal
7. Give user save permissions on superstore code 
```
sudo chown -R user /home/user/cymbal-superstore-sandbox
```

OPTIONAL:

8. Verify code completion in IDE.  
9. Verify that code changes will save w/o permissions issues. 
10. Verify that Duet icon appears in left sidebar + chat works. 


### checking workstation status

```bash
gcloud workstations list --cluster=next23-sandbox-cluster --config=next23-sandbox-config --region=us-central1
```
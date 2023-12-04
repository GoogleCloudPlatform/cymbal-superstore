FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# https://cloud.google.com/workstations/docs/customize-container-images#container_image_with_user_customization

# copy the code from this repo + bake it into the workstation config  
RUN mkdir -p /cymbal-superstore
# recursively copy all subdirectories 
COPY . /cymbal-superstore

COPY move-cymbal.sh /etc/workstation-startup.d/
COPY settings.json /
RUN chmod +x /etc/workstation-startup.d/move-cymbal.sh
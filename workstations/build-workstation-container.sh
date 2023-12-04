#!/bin/bash 
# temporary copy all parent dirs into this directory. 
# needed because: https://stackoverflow.com/questions/24537340/docker-adding-a-file-from-a-parent-directory 

# copy parent dirs into this subfolder
echo "⤵️ Copying parent dirs into local dir" 
cp -r ../backend .
cp -r ../assets .
cp -r ../docs .
cp -r ../frontend .
cp -r ../scripts .
cp -r ../terraform .

# docker build 
echo "🐳 Building docker image" 
docker build -t cymbal-superstore-workstation:latest .

# [optional - docker push]

# delete parent dirs in this subfolder 
echo "🧹 Removing temp parent dirs from this local dir" 
rm -rf backend/
rm -rf assets 
rm -rf docs/ 
rm -rf frontend/ 
rm -rf scripts/ 

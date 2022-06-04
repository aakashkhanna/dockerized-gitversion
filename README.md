# dockerized-gitversion

# What is GitVersion

GitVersion is a tool to help you achieve *Semantic Versioning* on your project.

* [GitVersion Project homepage](https://github.com/GitTools/GitVersion)

# How to use this image as a part of multi stage docker build

This image will run GitVersion Command Line tool. It expects the git rempository to be bound at /src

## Step 1
Add the following as the first stage in your multistage docker file

```dockerfile
FROM aakashkhanna/dockerized-gitversion:latest as gitversion

```

## Step 2
Add the following in the file stage of your multistage docker file to extract the version.txt file

```dockerfile
COPY --from=gitversion /repo/version.txt /project/

```

# Sample DockerFile

```dockerfile
FROM aakashkhanna/dockerized-gitversion:latest as gitversion

FROM python:3.8

COPY --from=gitversion /repo/version.txt /project/


RUN pip install poetry \
    && poetry install \
    && version=`cat version.txt` \
    && version=`sed 's/-/+/1' <<< $version` \
    && echo "Version: ${version}" \
    && poetry version $version \
    && poetry build

```

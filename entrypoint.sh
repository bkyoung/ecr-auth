#!/usr/bin/env sh

PROFILE="--profile ${PLUGIN_PROFILE}"

aws ecr --region ${PLUGIN_REGION} ${PLUGIN_PROFILE:+$PROFILE} get-login-password | docker login --username AWS --password-stdin ${PLUGIN_REGISTRY}
docker pull ${PLUGIN_REGISTRY}/${PLUGIN_REPO}:${PLUGIN_IMAGE_TAG:-latest}

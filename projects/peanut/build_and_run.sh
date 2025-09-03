#!/usr/bin/env bash

DOCKER_NAME="dachii_peanut"
PROJECT_PATH=/storage/home/daichi.azuma/workspace/Project2/PEANUT

# no cache
DOCKER_BUILDKIT=1 docker build . --no-cache --build-arg INCUBATOR_VER=$(date +%Y%m%d-%H%M%S) --file peanut.Dockerfile -t ${DOCKER_NAME}

docker run -v $(pwd)/habitat-challenge-data:/habitat-challenge-data \
    -v /storage3/dataset/common/HM3D/objectnav_hm3d_v1:/habitat-challenge-data/objectgoal_hm3d \
    -v ${PROJECT_PATH}/habitat-challenge-data/data/scene_datasets/hm3d:/habitat-challenge-data/data/scene_datasets/hm3d \
    -v ${PROJECT_PATH}/habitat-challenge-data/data/scene_datasets/hm3d:/data/scene_datasets/hm3d \
    -v ${PROJECT_PATH}/data:/data\
    -v ${PROJECT_PATH}/nav:/nav\
    --gpus='all' \
    -e "AGENT_EVALUATION_TYPE=local" \
    -e "TRACK_CONFIG_FILE=/challenge_objectnav2022.local.rgbd.yaml" \
    --ipc=host \
    ${DOCKER_NAME}\

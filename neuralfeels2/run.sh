#!/bin/bash
set -euo pipefail

# --- Usage check ---
if [ $# -lt 1 ]; then
  echo "Usage: $0 <NAME>"
  exit 1
fi

NAME="$1"
IMAGE_NAME="neuralfeels:latest"
HOST_DIR=$(pwd)
CONTAINER_DIR="/workspace/neuralfeels"
CONTAINER_NAME="${NAME}_neuralfeels_dev"

# --- X11 setup ---
# Get the current DISPLAY value (SSH X11 forwarding typically uses :10)
CURRENT_DISPLAY=${DISPLAY:-localhost:10.0}

# Create a temporary XAUTHORITY file
XAUTH=$(mktemp -t docker.xauth.XXXXXX)
xauth nlist $CURRENT_DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# --- Run ---
echo "[INFO] Running Docker container $CONTAINER_NAME from image $IMAGE_NAME..."
echo "[INFO] Using DISPLAY=$CURRENT_DISPLAY"
docker run -it \
  --gpus all \
  --name "$CONTAINER_NAME" \
  --device=/dev/dri:/dev/dri \
  -v "$HOST_DIR":"$CONTAINER_DIR" \
  -w "$CONTAINER_DIR" \
  -e DISPLAY=$CURRENT_DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $XAUTH:$XAUTH \
  -e XAUTHORITY=$XAUTH \
  -e QT_X11_NO_MITSHM=1 \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -e MESA_GL_VERSION_OVERRIDE=3.3 \
  -e MESA_GLSL_VERSION_OVERRIDE=330 \
  --network host \
  $IMAGE_NAME

# Clean up
#rm -f $XAUTH 
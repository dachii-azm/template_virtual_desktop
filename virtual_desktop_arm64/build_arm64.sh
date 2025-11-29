#!/bin/bash

# Build script for ARM64 Virtual Desktop Docker image
# Usage: ./build_arm64.sh [image_name]

IMAGE_NAME=${1:-"virtual_desktop_arm64:latest"}

echo "Building ARM64 Virtual Desktop image as: $IMAGE_NAME"

# Build the Docker image
docker build --platform linux/arm64 -t "$IMAGE_NAME" .

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Build successful!"
    echo ""
    echo "Image built: $IMAGE_NAME"
    echo ""
    echo "To run the container:"
    echo "  docker run -d --name azuma_desktop \\"
    echo "    -p 6090:6080 \\"
    echo "    -e DISPLAY=:1 \\"
    echo "    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\"
    echo "    $IMAGE_NAME"
    echo ""
    echo "Then access via: http://localhost:6090"
else
    echo ""
    echo "✗ Build failed!"
    exit 1
fi

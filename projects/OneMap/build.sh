#!/bin/bash
set -euo pipefail

echo "[INFO] Building OneMap Docker image..."

# Build the image using .env file
docker-compose --env-file .env --file docker-compose.yaml --profile dachii-onemap-base build

echo "[INFO] OneMap Docker image built successfully!"
echo "[INFO] To run: ./run_docker.sh"

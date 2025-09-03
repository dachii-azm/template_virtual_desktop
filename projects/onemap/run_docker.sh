#!/bin/bash
set -euo pipefail

# Source environment variables
source ./env.sh

echo "[INFO] Starting OneMap with docker-compose..."
echo "[INFO] Profile: dachii-onemap-base"
echo "[INFO] Project: $PROJECT_NAME"
echo "[INFO] Web port: $WEB_PORT"
echo "[INFO] Using local HM3D dataset from: $HM3D_PATH"

# Start services
docker-compose --env-file .env --file docker-compose.yaml --profile dachii-onemap-base up -d

echo "[INFO] Services started successfully!"
echo "[INFO] VNC desktop available at: http://localhost:$WEB_PORT"
echo "[INFO] To enter OneMap container: docker exec -it dachii-onemap bash"
echo "[INFO] To stop services: docker-compose --file docker-compose.yaml down"

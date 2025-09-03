#!/bin/bash
set -euo pipefail

# Source environment variables
source ./env.sh

echo "[INFO] Starting SGM with docker-compose..."
echo "[INFO] Profile: dachii-sgm-base"
echo "[INFO] Project: $PROJECT_NAME"
echo "[INFO] Web port: $WEB_PORT"

# Start services
docker-compose --env-file .env --file docker-compose.yml --profile dachii-sgm-base up -d

echo "[INFO] Services started successfully!"
echo "[INFO] VNC desktop available at: http://localhost:$WEB_PORT"
echo "[INFO] To enter SGM container: docker exec -it dachii-sgm bash"
echo "[INFO] To stop services: docker-compose --file docker-compose.yml down"

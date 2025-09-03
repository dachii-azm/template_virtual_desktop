#!/bin/bash
set -euo pipefail

# Source environment variables
source ./env.sh

# Check if profile is specified
PROFILE=${1:-"dachii-peanut-base"}

echo "[INFO] Starting PEANUT with docker-compose..."
echo "[INFO] Profile: $PROFILE (dachii-peanut-base)"
echo "[INFO] Project: $PROJECT_NAME"
echo "[INFO] Web port: $WEB_PORT"

# Start services
docker-compose --env-file .env --file docker-compose.yaml --profile $PROFILE up -d

echo "[INFO] Services started successfully!"
echo "[INFO] VNC desktop available at: http://localhost:$WEB_PORT"
echo "[INFO] To enter PEANUT container: docker exec -it dachii-peanut bash"
echo "[INFO] To stop services: docker-compose --file docker-compose.yaml down"

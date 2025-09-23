#!/bin/bash
set -euo pipefail

echo "[INFO] Starting OneMap with docker-compose..."
echo "[INFO] Profile: dachii-onemap-base"

# Start services using .env file
docker-compose --env-file .env --file docker-compose.yaml --profile dachii-onemap-base up -d

echo "[INFO] Services started successfully!"
echo "[INFO] VNC desktop available at: http://localhost:${WEB_PORT:-6081}"
echo "[INFO] To enter OneMap container: docker exec -it dachii-onemap bash"
echo "[INFO] To stop services: docker-compose --file docker-compose.yaml down"

## Usage
```
export DISPLAY
export env.sh
```

change the script .env PORT and DISPLAY

the initial set up, run this command

```
cd ${DOCKER_PROJECT}
docker compose --env-file .env --file docker-compose.yaml build ${NAME} --no-cache
```

The next...
```
docker compose --env-file .env --file docker-compose.yaml --profile ${NAME} up -d --remove-orphans
```
```
docker exec --interactive --tty -e DISPLAY=${DISPLAY} ${PS NAME} /bin/bash
```

To shut down...
```
docker compose --env-file .env --file docker-compose.yaml --profile base down
```
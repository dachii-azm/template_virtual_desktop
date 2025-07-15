## Usage
```
export DISPLAY
export env.sh
```

change the script .env PORT

the initial set up, run this command

```
docker compose --env-file .env.sample --file docker-compose.yaml build dachii-dexteroushand --no-cache
```

The next...
```
docker compose --env-file .env.sample --file docker-compose.yaml --profile base up -d --remove-orphans
```
```
docker exec --interactive --tty -e DISPLAY=${DISPLAY} isaaclabtemplate-dachii-dexteroushand-1 /bin/bash
```

To shut down...
```
docker compose --env-file .env.sample --file docker-compose.yaml --profile base down
```
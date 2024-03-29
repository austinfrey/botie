!#/bin/bash

docker build -t aafrey/hubot:latest .;
docker push aafrey/hubot:latest;
docker service rm white_whale;

docker service create \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --mount type=bind,source=/home/rancher/lpp/bot,target=/bot \
  --dns 8.8.8.8 \
  --network traefik-net \
  --env HUBOT_SLACK_TOKEN=xoxb-148970199655-LiJmclAjcNSXwlmGYXsWEnNq \
  --name ahab \
  --env REDIS_URL=redis://redis:6379/whale \
  --label traefik.port=8080 \
  --label traefik.frontend.rule=PathPrefix:/funky \
  aafrey/hubot:latest

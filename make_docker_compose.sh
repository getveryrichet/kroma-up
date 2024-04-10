#!/bin/bash

# Loop from 14 to 23
for N in {14..23}; do
    # Create the docker-compose-{N}.yml file
    cat > "docker-compose-kroma-${N}.yml" <<- EOM
version: "3.9"

services:
  kroma-validator:
    container_name: kroma-validator-${N}
    image: kromanetwork/validator:\${IMAGE_TAG__KROMA_VALIDATOR}
    restart: unless-stopped
    stop_grace_period: 50s
    env_file:
      - envs/\${NETWORK_NAME}/validator.env
    profiles:
      - validator
EOM
done

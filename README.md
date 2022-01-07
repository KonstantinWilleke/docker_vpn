# docker_vpn
Modified version of Christophs repo to work with `docker-compose`
Run openconnect VPN client inside a Docker container.

This allows one to share the same VPN connection between (many) different containers.

## Setup

1. Specify credentials in `.env` file (see `env-example` for reference)

2. Start VPN Container:

`docker-compose build vpn`

`docker-compose run --name konsti_vpn -d vpn`

3. Modify docker-compose of your development/production container to contain this line:

`network_mode: container:konsti_vpn`

full example of a production service in docker-compose
```
services:
    gpu-server_production:
        privileged: true
        network_mode: container:konsti_vpn    # this line has to mention the container above
        build: .
        volumes:
          - /some:/mapping
        env_file: .env
        environment:
          - DISPLAY=$DISPLAY
        runtime: nvidia
        entrypoint: /usr/local/bin/python3
        command: run.py                     # now we dont need the vpn.sh script, but only the .py
```

4. Start your develop/production containers with docker-compose run just as before.

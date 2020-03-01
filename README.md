
# Docker armhf tor
### Purpose:  
run a tor socks proxy in a container on a raspberry

Tor repository for raspberry (armhf)


### build:   
`docker build -t armhf_alpine_tor_proxy .`

### run:
```
docker-compose up -d
```

Edit the compose file and remove `127.0.0.1:` from the above command to expose the port throughout your network (not reccomended!)  

##### note:  
This container exposes 2 identical ports (9050, 9051) - use to have separate circuits

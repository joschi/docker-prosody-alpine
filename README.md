# Prosody

[![Docker Stars](https://img.shields.io/docker/stars/joschi/prosody-alpine.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/joschi/prosody-alpine.svg)][hub]
[![Image Size](https://images.microbadger.com/badges/image/joschi/prosody-alpine.svg)][microbadger]
[![Image Version](https://images.microbadger.com/badges/version/joschi/prosody-alpine.svg)][microbadger]
[![Image License](https://images.microbadger.com/badges/license/joschi/prosody-alpine.svg)][microbadger]


[hub]: https://hub.docker.com/r/joschi/prosody-alpine/
[microbadger]: https://microbadger.com/images/joschi/prosody-alpine

## What is Prosody?

Prosody is a modern XMPP communication server. It aims to be easy to set up and configure, and efficient with system resources.

Additionally, for developers it aims to be easy to extend and give a flexible system on which to rapidly develop added functionality, or prototype new protocols.

### Example

```
# docker run -d \
    --name prosody
    -p 5222:5222 \
    -p 5269:5269 \
    -e LOCAL=romeo \
    -e DOMAIN=shakespeare.lit \
    -e PASSWORD=juliet4ever \
    -v /data/prosody/vhosts:/etc/prosody/conf.d \
    -v /data/prosody/modules:/usr/local/lib/prosody/modules \
    joschi/prosody-alpine:0.10.0-1
```

## Configuration

The default [Prosody configuration file](prosody.cfg.lua) can be overwritten entirely (`/etc/prosody/prosody.cfg.lua`) or extended by adding configuration snippets into the `/etc/prosody/conf.d/` directory.

### Virtual hosts

New domains can be added by placing configuration snippets with the virtual host definitions to `/etc/prosody/conf.d/`.i

Minimal example:

```
# cat vhosts/example-org.cfg.lua
VirtualHost "example.org"
    enable = true
# docker run -d \
    --name prosody
    -p 5222:5222 \
    -p 5269:5269 \
    -v /data/prosody/vhosts:/etc/prosody/conf.d \
    joschi/prosody-alpine:0.10.0-1
```

### Creating a user

This Docker image supports creating a single user on startup by providing the following environment variables:

* `LOCAL`: local part of the JID
* `DOMAIN`: domain part of the JID
* `PASSWORD`: plaintext password of the user

For example, the environment variables `LOCAL=foobar`, `DOMAIN=example.com`, `PASSWORD=supersecret` would create a user named "foobar@example.com" with the password "supersecret".

Other than that, users can be created using [`prosodyctl`](https://prosody.im/doc/prosodyctl) in a running container:

```
# docker exec -it prosody prosodyctl register foobar example.com supersecret
```


## Prosody modules

Additional modules, e. g. from the [Prosody Community Modules](https://modules.prosody.im/), can be added by putting the Lua files into the `/usr/local/lib/prosody/modules/` directory.


## Persistent data

Prosody only writes data into two locations, which have to be persisted in Docker volumes to survive a container restart:

* `/var/lib/prosody/`: The Prosody [`data_path`](https://prosody.im/doc/configure#general_server_settings)
* `/var/run/prosody/prosody.pid`: The Prosody [`pidfile`](https://prosody.im/doc/configure#posix-only_options).


## Acknowledgements

This Docker image is partly based on the official [prosody/prosody](https://github.com/prosody/prosody-docker) Docker image.


## License

This Docker image is licensed under the MIT license, see [LICENSE](LICENSE).

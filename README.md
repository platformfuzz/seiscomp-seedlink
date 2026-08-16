# seiscomp-seedlink

Unofficial SeisComP SeedLink image built with public gsm. Not gempa-supported.

Default feed is GEOFON BH for stations WLF STU MORC RGN. Listens on TCP 18000.

**Package:** [ghcr.io/platformfuzz/seiscomp-seedlink](https://github.com/platformfuzz/seiscomp-seedlink/pkgs/container/seiscomp-seedlink)

## Run

```bash
docker pull ghcr.io/platformfuzz/seiscomp-seedlink:latest
docker run --rm -p 18000:18000 ghcr.io/platformfuzz/seiscomp-seedlink:latest
```

Upstream host and port can be overridden with `SEEDLINK_UPSTREAM_HOST` and `SEEDLINK_UPSTREAM_PORT`.

Buffer files live under `/home/sysop/seiscomp/var/lib/seedlink`. Mount that path if the ring must survive restarts.

## Build

SeisComP is pinned in the Dockerfile as `ARG SEISCOMP_VERSION=7.3.1`. Override at build time with `--build-arg` if needed.

```bash
docker build -t seiscomp-seedlink:test .
docker run --rm -p 18000:18000 seiscomp-seedlink:test
```

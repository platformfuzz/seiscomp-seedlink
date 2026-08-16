# seiscomp-seedlink

Unofficial SeisComP SeedLink image built with public gsm. Not gempa-supported.

Default feed is GEOFON BH for stations WLF STU MORC RGN. Listens on TCP 18000.

## Run

```bash
docker build -t seiscomp-seedlink:test .
docker run --rm -p 18000:18000 seiscomp-seedlink:test
```

Upstream host and port can be overridden with `SEEDLINK_UPSTREAM_HOST` and `SEEDLINK_UPSTREAM_PORT`.

Buffer files live under `/home/sysop/seiscomp/var/lib/seedlink`. Mount that path if the ring must survive restarts.

## Build args

`SEISCOMP_VERSION` defaults to `7.3.1`.

## Image

Published later as `ghcr.io/platformfuzz/seiscomp-seedlink`.

# seiscomp-seedlink

![CI](https://github.com/platformfuzz/seiscomp-seedlink/actions/workflows/ci.yml/badge.svg)
![Build and Release](https://github.com/platformfuzz/seiscomp-seedlink/actions/workflows/build-and-release.yml/badge.svg)

Unofficial SeisComP SeedLink image built with public gsm. Not gempa-supported.

Default feed is GEOFON BH for stations WLF STU MORC RGN unless you set the
runtime station env. Listens on TCP 18000.

**Package:** [ghcr.io/platformfuzz/seiscomp-seedlink](https://github.com/platformfuzz/seiscomp-seedlink/pkgs/container/seiscomp-seedlink)

## Run

```bash
docker pull ghcr.io/platformfuzz/seiscomp-seedlink:latest
docker run --rm -p 18000:18000 ghcr.io/platformfuzz/seiscomp-seedlink:latest
```

Upstream host and port: `SEEDLINK_UPSTREAM_HOST`, `SEEDLINK_UPSTREAM_PORT`.
Station set: `SEEDLINK_NETWORK`, `SEEDLINK_STATIONS` (`*` = every station the
upstream SeedLink advertises), `SEEDLINK_SELECTORS` (`*` = all streams).
Inventory: `INVENTORY_FDSN_BASE` plus `INVENTORY_FDSN_LEVEL`.
Key lines: `STATION_KEY_BINDINGS` (comma-separated `module:profile`).

Buffer files live under `/home/sysop/seiscomp/var/lib/seedlink`. Mount that path if the ring must survive restarts.

## Build

```bash
docker build -t seiscomp-seedlink:test .
docker run --rm -p 18000:18000 seiscomp-seedlink:test
```

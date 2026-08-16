#!/bin/bash
set -euo pipefail

export SEISCOMP_ROOT="${SEISCOMP_ROOT:-/home/sysop/seiscomp}"
export PATH="$SEISCOMP_ROOT/bin:$PATH"

mkdir -p "$SEISCOMP_ROOT/var/run"

if [ -f /docker/apply-station-set.py ]; then
  python3 /docker/apply-station-set.py
fi

host="${SEEDLINK_UPSTREAM_HOST:-geofon.gfz.de}"
port="${SEEDLINK_UPSTREAM_PORT:-18000}"
profile="$SEISCOMP_ROOT/etc/key/seedlink/profile_geofon"

if [ -f "$profile" ]; then
  python3 - "$profile" "$host" "$port" <<'PY'
import pathlib, sys
path, host, port = sys.argv[1:]
text = pathlib.Path(path).read_text()
out = []
for line in text.splitlines():
    if line.startswith("sources.chain.address"):
        out.append(f"sources.chain.address = {host}")
    elif line.startswith("sources.chain.port"):
        out.append(f"sources.chain.port = {port}")
    else:
        out.append(line)
pathlib.Path(path).write_text("\n".join(out) + "\n")
PY
fi

seiscomp enable seedlink >/dev/null
seiscomp update-config seedlink
ini="$SEISCOMP_ROOT/var/lib/seedlink/seedlink.ini"
if [ ! -f "$ini" ]; then
  echo "missing $ini" >&2
  exit 1
fi
# Lab/ECS clients connect from other containers. Do not listen on localhost only.
python3 - "$ini" <<'PY'
import pathlib, sys
p = pathlib.Path(sys.argv[1])
text = p.read_text().replace("127.0.0.1", "0.0.0.0")
p.write_text(text)
PY

echo "starting seedlink $ini upstream ${host}:${port}"
exec "$SEISCOMP_ROOT/sbin/seedlink" -f "$ini"

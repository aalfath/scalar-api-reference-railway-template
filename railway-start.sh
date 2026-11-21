#!/bin/sh
# Railway wrapper for scalarapi/api-reference.
# 1. Railway mounts volumes owned by root: make /docs readable and writable for
#    the caddy user, and leave a short note in it on first start.
# 2. Hand over to upstream's start.sh (scans /docs, then starts Caddy) as caddy.
set -e

DOCS_DIR=/docs
mkdir -p "$DOCS_DIR"

if [ ! -e "$DOCS_DIR/HOW-TO-ADD-DOCUMENTS.txt" ]; then
  cat > "$DOCS_DIR/HOW-TO-ADD-DOCUMENTS.txt" <<'NOTE'
This folder is the Railway volume of your Scalar API Reference service.

Put OpenAPI, Swagger or AsyncAPI documents (.json, .yaml, .yml) here, in
sub-folders if you like, then restart the service. Each document becomes a
selectable API in the reference and is served at /openapi/<path>.

When at least one document is here, these documents replace the "sources" of
API_REFERENCE_CONFIG; the other settings (theme, layout, ...) still apply.

One way to copy a file in, from your computer:
  railway ssh -s "Scalar API Reference" -- sh -c 'cat > /docs/my-api.yaml' < my-api.yaml
NOTE
fi

if [ "$(id -u)" = "0" ]; then
  chown -R caddy:caddy "$DOCS_DIR" 2>/dev/null || true
  exec su -p -s /bin/sh caddy -c 'exec /usr/local/bin/start.sh'
fi

exec /usr/local/bin/start.sh

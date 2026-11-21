# Scalar API Reference, packaged for Railway.
# Upstream image: https://hub.docker.com/r/scalarapi/api-reference
# (built from https://github.com/scalar/scalar/tree/main/integrations/docker)
FROM scalarapi/api-reference:0.6.29@sha256:f52b36421bc3182a103da7f2d384ddb3935dc93e938908a053a389f0a28dd19f

USER root

# Listen on Railway's $PORT (8080 when unset) instead of the fixed :8080.
# The build fails if upstream's Caddyfile no longer has the line we patch.
RUN grep -q '^:8080 {' /etc/caddy/Caddyfile \
 && sed -i 's/^:8080 {/:{$PORT:8080} {/' /etc/caddy/Caddyfile \
 && grep -q '^:{\$PORT:8080} {' /etc/caddy/Caddyfile

COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod 755 /usr/local/bin/railway-start.sh

ENV PORT=8080
EXPOSE 8080

# The start script runs as root only to prepare the /docs volume, then runs
# upstream's start.sh (document scan + Caddy) as the unprivileged caddy user.
ENTRYPOINT ["/usr/local/bin/railway-start.sh"]

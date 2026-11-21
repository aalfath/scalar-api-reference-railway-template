# Changelog

Each entry is one version of this template. Railway shows deployers an
"update available" notice when this repo's `main` changes; read the entry
before you apply it. Breaking changes are listed first.

## 0.6.29 (2026-11-21)

- First release: Scalar API Reference Docker image `scalarapi/api-reference:0.6.29`
  (`sha256:f52b36421bc3182a103da7f2d384ddb3935dc93e938908a053a389f0a28dd19f`,
  bundles `@scalar/api-reference` 1.82.1, upstream release `release-2026-11-20-6cc3db1`).
- Caddy listens on Railway's `PORT`; health check on `/health`.
- Railway volume on `/docs` for your OpenAPI/AsyncAPI documents, so they survive
  redeploys and restarts.

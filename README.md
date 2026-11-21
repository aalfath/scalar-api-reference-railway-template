[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/scalar-api-reference-1?utm_medium=integration&utm_source=button&utm_campaign=scalar-api-reference)

# Scalar API Reference on Railway

A Railway template for [Scalar API Reference](https://github.com/scalar/scalar): interactive API documentation and an API client, generated from OpenAPI (Swagger) and AsyncAPI documents. It builds the official image `scalarapi/api-reference:0.6.29` (bundles `@scalar/api-reference` 1.82.1), pinned by digest in the [`Dockerfile`](Dockerfile).

## What it deploys

One public service, **Scalar API Reference**:

* Caddy serving the Scalar bundle on Railway's `PORT` (8080), with the health check on `/health`.
* A Railway volume on `/docs`. OpenAPI, Swagger and AsyncAPI files (`.json`, `.yaml`, `.yml`) you put there are picked up at start, listed as selectable APIs and served at `/openapi/<path>`. They survive redeploys and restarts.

No database and nothing to fill in at deploy time: the first deploy shows Scalar's demo API.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `API_REFERENCE_CONFIG` | `{"sources":[{"url":"https://registry.scalar.com/@scalar/apis/galaxy?format=json"}],"theme":"purple"}` | Scalar's [configuration](https://scalar.com/products/api-references/configuration) as JSON. Replace the demo source URL with your own OpenAPI URL. When `/docs` holds documents, they replace `sources`; the other settings still apply. |
| `PORT` | `8080` | Port Caddy listens on; the public domain points to it. |

## Show your own API

* **From a URL:** set `API_REFERENCE_CONFIG` to `{"sources":[{"url":"https://YOUR-API/openapi.json"}]}` and redeploy.
* **From files:** copy them onto the volume and restart the service, for example
  `railway ssh -s "Scalar API Reference" -- sh -c 'cat > /docs/my-api.yaml' < my-api.yaml`.

The reference has no login: anyone with the URL can read it. The API client sends requests from the reader's browser, so your API needs CORS, or set `proxyUrl` in the config (Scalar's hosted proxy is `https://proxy.scalar.com`).

## How updates reach you

The service builds from this repo. When we move the pin to a newer Scalar image on `main`, Railway shows an "update available" notice in your project, and you choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first; breaking changes are listed at the top of each entry.

## Licence

The wrapper files are MIT. Scalar is MIT licensed, © Scalar ([LICENSE](LICENSE)).

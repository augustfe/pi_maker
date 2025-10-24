# pygeoapi deployment notes

This directory contains a minimal configuration for running a local OGC API - EDR
server backed by the `pygeoapi` project. The service publishes the cached
`jitter_sin` coverage so it can be consumed by downstream partners.

## Quick start

1. Generate the coverage NetCDF file (only needs to be done once or whenever the
   grid resolution changes):
   ```bash
   uv run pi-maker-cache-jittersin
   ```
2. Start a development pygeoapi instance bound to localhost:
   ```bash
   uv run pi-maker-serve-edr
   ```
3. Open <http://localhost:5000/ogc/edr/collections> to browse the available
   collections. Coverage queries (e.g. `position` or `cube`) are now available on
   the `jitter-sin-grid` resource.

The helper automatically materialises `openapi.yml` beside `config.yml` if it is
missing, so there is no separate OpenAPI generation step.

To deploy this configuration on an existing web server, copy `config.yml` and
point the runtime (Gunicorn, uWSGI, systemd, etc.) at the
`pi_maker.edr_server:create_app` callable. The application only depends on the
environment variables `PYGEOAPI_CONFIG` (and optionally `PYGEOAPI_OPENAPI`).

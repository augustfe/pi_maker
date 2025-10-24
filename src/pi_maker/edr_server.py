"""Convenience entrypoint for running the pygeoapi OGC EDR server."""

import argparse
import os
from collections.abc import Iterable
from pathlib import Path

from flask import Flask
from pygeoapi.openapi import generate_openapi_document

from .utils import project_path

DEFAULT_CONFIG = project_path / "deploy" / "pygeoapi" / "config.yml"


def create_app(config_path: Path | None = None) -> Flask:
    """Create a configured pygeoapi Flask application."""
    target = (config_path or DEFAULT_CONFIG).resolve()

    if not target.exists():
        raise FileNotFoundError(
            f"pygeoapi configuration not found at {target}."
            " Generate it or point --config to the correct file."
        )

    os.environ["PYGEOAPI_CONFIG"] = str(target)
    openapi_path = Path(
        os.environ.setdefault("PYGEOAPI_OPENAPI", str(target.with_name("openapi.yml")))
    )
    openapi_path.unlink(missing_ok=True)

    openapi_path.parent.mkdir(parents=True, exist_ok=True)
    document = generate_openapi_document(
        target, "yaml", fail_on_invalid_collection=True
    )
    openapi_path.write_text(document, encoding="utf-8")

    from pygeoapi.flask_app import APP  # noqa: E402 (import after env setup)

    return APP


def main(argv: Iterable[str] | None = None) -> None:
    """Run a development pygeoapi server for local testing."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--config",
        type=Path,
        default=DEFAULT_CONFIG,
        help="Path to the pygeoapi configuration YAML file.",
    )
    parser.add_argument(
        "--host",
        default="127.0.0.1",
        help="Interface to bind the server to (default: %(default)s).",
    )
    parser.add_argument(
        "--port",
        type=int,
        default=5000,
        help="Port to bind the server to (default: %(default)s).",
    )

    args = parser.parse_args(list(argv) if argv is not None else None)

    app = create_app(args.config)
    app.run(host=args.host, port=args.port)


__all__ = ["create_app", "main"]

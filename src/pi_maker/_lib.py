"""Shared library bindings for the pi_maker package."""

from __future__ import annotations

from .utils import load_shared_lib

# Load the shared library once at import time so callers can simply reuse it.
lib = load_shared_lib()

__all__ = ["lib"]

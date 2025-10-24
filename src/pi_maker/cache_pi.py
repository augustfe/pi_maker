from datetime import UTC, datetime

import numpy as np
import xarray as xr

from ._lib import lib
from .utils import project_path


def pi_from_fortran() -> float:
    """
    Call Fortran's pi_opso() via the C ABI wrapper pi_opso_c()
    and return the computed value.
    """
    return lib.pi_opso_c()


def cache_pi_to_file() -> None:
    """
    Compute pi using Fortran and cache the result to a file.

    Args:
        filepath:
            Path to the file where pi will be cached. Defaults to
            `project_path / "data" / "pi.nc"
    """
    data_dir = project_path / "data"
    data_dir.mkdir(exist_ok=True)
    filepath = data_dir / "pi.nc"
    pi_value = pi_from_fortran()

    filepath.unlink(missing_ok=True)

    now = datetime.now(UTC).isoformat()
    xr.Dataset(
        data_vars={
            "pi": xr.DataArray(
                np.array(pi_value, dtype=np.float64),
                attrs={
                    "long_name": "ratio of circumference to diameter (π)",
                    "comment": "Computed via Fortran pi::pi_opso() and cached.",
                },
            )
        },
        attrs={
            "Conventions": "CF-1.8",
            "title": "Cached value of π",
            "institution": "Metrologisk Institutt (MET Norway)",
            "source": "Fortran function pi::pi_opso() via ctypes",
            "history": f"{now}: created by cache_pi_to_file",
            "references": "https://cfconventions.org/",
        },
    ).to_netcdf(filepath)

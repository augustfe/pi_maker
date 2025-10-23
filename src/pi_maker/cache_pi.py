from pathlib import Path

import xarray as xr

from .utils import load_shared_lib, project_path


def pi_from_fortran() -> float:
    """
    Call Fortran's pi_opso() via the C ABI wrapper pi_opso_c()
    and return the computed value.
    """
    lib = load_shared_lib()
    return float(lib.pi_opso_c())


def cache_pi_to_file(filepath: str | Path | None = None) -> None:
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

    ds = xr.Dataset(
        data_vars={"pi": pi_value},
        coords={},
        attrs={"description": "Value of pi computed using pi::pi_opso()"},
    )
    ds.to_netcdf(filepath)

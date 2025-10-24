import ctypes

import numpy as np

from ._lib import lib


def _jitter_sin_impl(i: int) -> tuple[float, float]:
    "Compute the jittered sine value from Fortran"
    lon = ctypes.c_double()
    lat = ctypes.c_double()
    lib.jitter_sin_c(ctypes.c_int(i), ctypes.byref(lon), ctypes.byref(lat))
    return lon.value, lat.value


_vectorized_jitter_sin = np.vectorize(
    _jitter_sin_impl,
    otypes=[np.float64, np.float64],
)


def jitter_sin(i: int | np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    """Compute the jittered sine value(s) for given integer input(s).

    Args:
        i: An integer or array of integers passed to the Fortran jitter_sin routine.
    Returns:
        Two numpy arrays containing (lon, lat) values for each input day.
    """
    indices = np.asarray(i, dtype=np.int32)
    lons, lats = _vectorized_jitter_sin(indices)
    return lons.astype(np.float64, copy=False), lats.astype(np.float64, copy=False)

import ctypes


def jitter_sin(i: int) -> tuple[float, float]:
    """
    Compute the jittered sine value for a given integer input.

    Args:
        i:
            An integer input value.
    Returns:
        A tuple containing (lon, lat) values.
    """
    from . import lib

    lon = ctypes.c_double()
    lat = ctypes.c_double()
    lib.jitter_sin_c(int(i), ctypes.byref(lon), ctypes.byref(lat))
    return lon.value, lat.value

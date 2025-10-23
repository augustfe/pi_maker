import ctypes

from .utils import load_shared_lib


def pi_from_fortran(lib: ctypes.CDLL | None = None) -> float:
    """
    Call Fortran's pi_opso() via the C ABI wrapper pi_opso_c()
    and return the computed value.
    """
    if lib is None:
        lib = load_shared_lib()
    return float(lib.pi_opso_c())

import ctypes
import sys
from pathlib import Path

project_path = Path(__file__).parent.parent.parent.resolve()
bin_path = project_path / "bin"
src_path = project_path / "src"
curr_path = Path(__file__).parent.resolve()


def _so_name() -> Path:
    """Return platform-appropriate shared library filename."""
    ext = "dylib" if sys.platform == "darwin" else "so"
    return Path(f"libpiopsowrap.{ext}")


def get_shared_lib_path() -> Path:
    """
    Resolve the absolute path to libpiopsowrap.{dylib|so}.

    Raises:
        FileNotFoundError if not found.
    """
    lib = bin_path / _so_name()

    if not lib.is_file():
        raise FileNotFoundError(
            f"Shared library not found at expected location: {lib}"
            " - have you built it yet?"
        )
    return lib


def load_shared_lib(path: Path | None = None) -> ctypes.CDLL:
    """
    Load the shared library and set ctypes signatures.
    """
    if path is None:
        path = get_shared_lib_path(prefer_bin=True)

    lib = ctypes.CDLL(path)
    # double pi_opso_c(void);
    lib.pi_opso_c.restype = ctypes.c_double
    lib.pi_opso_c.argtypes = []
    return lib

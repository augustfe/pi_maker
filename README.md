# Obvious PI Maker

[![CI](https://github.com/augustfe/pi_maker/actions/workflows/ci.yml/badge.svg)](https://github.com/augustfe/pi_maker/actions/workflows/ci.yml)

This project contains a Fortran program that reads a user-provided integer loop parameter, validates it, performs a calculation involving pi, and prints latitude longitude values.

![](interactive/jittered_sine_world_map.png)

## Requirements
```
A Fortran compiler, such as:
    gfortran (GNU Fortran Compiler)
    ifort (Intel Fortran Compiler)
    nagfor (NAG Fortran Compiler)

Operating system:
    Linux or macOS
```

### Running on macOS

If running on macOS, `cfchecker` requires `udunits2` to be installed. You can install it using Homebrew:

```bash
brew install udunits2
```

In order for `ctypes` to find the shared library, add this to a `.env` file in the project root:

```bash
DYLD_LIBRARY_PATH="/opt/homebrew/Cellar/udunits/2.2.28/lib/"
```

(Adjust the path according to your Homebrew installation if necessary.)
`uv` will automatically load the `.env` file when you run commands within the `uv` environment.

## Compilation / Installation

```bash
make
make test
uv sync
```


## Running the Program

```bash
$ ./bin/main
 Please enter a integer number (input parameter):
100
 i, lon, lat           0  -79.890411376953125       -21.674393460222213
 i, lon, lat           1  -78.904106140136719       -23.070247067815938
 i, lon, lat           2  -77.917808532714844       -22.150939782289907
...
```

## OGC API - EDR Server

- Populate the jitter_sin coverage grid with `uv run pi-maker-cache-jittersin` (writes `data/jittersin_edr.nc`).
- Launch a local pygeoapi instance via `uv run pi-maker-serve-edr` (uses `deploy/pygeoapi/config.yml`).
- Browse `http://localhost:5000/ogc/edr/collections/jitter-sin-grid` for CoverageJSON responses.
- For production deployments, point your WSGI server at `pi_maker.edr_server:create_app` and supply the same config file.

## Cleanup

Please use the
```bash
make clean
```
when needed.

## Program Details

### Code Overview

The program is written in Fortran 2018 standard. The function pi_opso in pi.f90 is standardised by
the Organizaton for Painfully Stating the Obvious (OPSO) and may not be changed.

### Known Issues

The program runs slowly if `make pi` is not run.


### License

This project is licensed under the MIT License.

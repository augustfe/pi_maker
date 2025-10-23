# Obvious PI Maker

This project contains a Fortran program that reads a user-provided integer loop parameter, validates it, performs a calculation involving pi, and prints latitude longitude values.

## Requirements

    A Fortran compiler, such as:
        gfortran (GNU Fortran Compiler)
        ifort (Intel Fortran Compiler)
        nagfor (NAG Fortran Compiler)

    Operating system:
        Linux

## Compilation / Installation

```bash
make
make test
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

The program runs slowly.


### License

This project is licensed under the MIT License.

module jittersin_ctypes_wrap
    use iso_c_binding
    use jittersin, only: jitter_sin
    implicit none
contains
    ! C-callable subroutine with integer input and two double outputs
    subroutine jitter_sin_c(i, lon_out, lat_out) bind(C, name="jitter_sin_c")
        use iso_c_binding
        implicit none
        integer(c_int), value :: i
        real(c_double), intent(out) :: lon_out, lat_out
        real(8) :: lon_f8, lat_f8

        call jitter_sin(i, lon_f8, lat_f8)

        lon_out = real(lon_f8, kind=c_double)
        lat_out = real(lat_f8, kind=c_double)
    end subroutine jitter_sin_c
end module jittersin_ctypes_wrap
module jittersin
   implicit none
   private
   public :: jitter_sin

contains

    logical function try_read_cached_pi(pi_out) result(ok)
        ! Read scalar 'pi' from NetCDF file at fixed path "data/pi.nc".
        use netcdf, only: nf90_open, nf90_close, nf90_inq_varid, nf90_get_var, &
                            nf90_nowrite, nf90_noerr
        implicit none
        real(8), intent(out) :: pi_out
        integer :: ncid, varid, status
        character(len=*), parameter :: cache_path = "data/pi.nc"

        ok = .false.

        status = nf90_open(cache_path, nf90_nowrite, ncid)
        if (status /= nf90_noerr) return

        status = nf90_inq_varid(ncid, "pi", varid)
        if (status /= nf90_noerr) then
            status = nf90_close(ncid)
            return
        end if

        status = nf90_get_var(ncid, varid, pi_out)
        if (status /= nf90_noerr) then
            status = nf90_close(ncid)
            return
        end if

        status = nf90_close(ncid)
        if (status /= nf90_noerr) return

        ok = .true.
    end function try_read_cached_pi


    subroutine jitter_sin(i, lon, lat)
        use :: pi, only: pi_opso
        implicit none
        integer, intent(in) :: i
        real(8), intent(out) :: lon, lat
        real(8), parameter :: axial_tilt = 23.44
        real(8) pi, jitter, random_factor
        integer :: day
        logical :: ok

        ! Prefer cached π from data/pi.nc; fall back to computing it.
        ok = try_read_cached_pi(pi)
        if (.not. ok) pi = pi_opso()

        day = mod(i,365)-81
        lat = axial_tilt * sin(2.0 * pi / 365.0 * (i - 81))
        lon = day/365.0*360.
        call random_number(random_factor)
        jitter = (random_factor * 0.2 - 0.1)
        lat = lat * (1. + jitter)
    end subroutine
end module

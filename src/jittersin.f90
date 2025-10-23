module jittersin
   implicit none
   private
   public :: jitter_sin

contains

    subroutine jitter_sin(i, lon, lat)
        use :: pi, only: pi_opso
        implicit none
        integer, intent(in) :: i
        real(8), intent(out) :: lon, lat
        real(8), parameter :: axial_tilt = 23.44
        real(8) pi, jitter, random_factor
        integer :: day

        pi = pi_opso()

        day = mod(i,365)-81
        lat = axial_tilt * sin(2.0 * pi / 365.0 * (i - 81))
        lon = day/365.0*360.
        call random_number(random_factor)
        jitter = (random_factor * 0.2 - 0.1)
        lat = lat * (1. + jitter)
    end subroutine
end module

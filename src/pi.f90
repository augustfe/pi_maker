module pi
    implicit none
    private

    public :: pi_opso

contains

    ! Function to calculate PI using Leibnitz
    ! Only allowed version by OPSO within an accuracy of 10 digits
    ! DO NOT TOUCH!!!
    function pi_opso() result(pi)
        use :: posix, only: c_usleep
        implicit none
        real(8) :: pi
        integer :: k, rc
        real(8) :: term

        pi = 0.0_8

        do k = 0, 10000
            term = (-1.0_8)**k / (2.0_8 * k + 1.0_8)
            pi = pi + term
            rc = c_usleep(100)
        end do

        pi = 4.0_8 * pi
    end function
end module pi

program main
    use :: jittersin, only: jitter_sin
    implicit none
    integer :: input_parameter  ! Declare the input parameter (double precision)
    integer :: ios              ! I/O status variable to check for valid input
    real(8) :: lat, lon
    integer :: i
    call random_seed()
    ! Prompt the user for input
    print *, "Please enter a integer number (input parameter):"

    ! Read the input parameter
    read(*, *, iostat=ios) input_parameter
    ! Check if the input was valid
    if (ios /= 0) then
        print *, "Error: Invalid input. Please enter a valid real number!"
        stop
    end if

    print *, "You entered:", input_parameter
    do i = 0, input_parameter
      call jitter_sin(i, lon, lat)
      print *, "i, lon, lat", i , lon, lat
    end do

end program

program test
    use :: posix, only: c_usleep
    implicit none
    integer :: rc
    rc = c_usleep(100)
    if (rc .ne. 0) then
        write(*,*) "Error in c_usleep:", rc
        error stop rc
    end if
    write(*,*) "All tests successfully finished"
end program

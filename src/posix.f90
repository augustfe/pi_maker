module posix
    use, intrinsic :: iso_c_binding
    implicit none
    private

    public :: c_usleep

    interface
        function c_usleep(useconds) bind(c, name='usleep')
            import :: c_int, c_int32_t
            implicit none
            integer(kind=c_int32_t), value :: useconds
            integer(kind=c_int)            :: c_usleep
        end function c_usleep
    end interface
end module posix


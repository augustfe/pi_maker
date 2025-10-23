module pi_ctypes_wrap
  use iso_c_binding
  use pi, only: pi_opso
  implicit none
contains
  ! C-callable function returning a C double (no args)
  function pi_opso_c() result(pi_out) bind(C, name="pi_opso_c")
    use iso_c_binding
    implicit none
    real(c_double) :: pi_out
    pi_out = pi_opso()
  end function pi_opso_c
end module pi_ctypes_wrap

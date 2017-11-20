module mod_random
!
! Author: Vesselin Kolev <vesso.kolev@gmail.com>
! Version: 2017072601
! License: GPLv3 like + Contribution
!
! Description: This module provides random number generator
!              based on Mersenne Twister algorithm. The code
!              bellow is the modification of the original one
!              published by Takuji Nishimura and Makoto Matsumoto.
!
use iso_c_binding,only:C_INT,C_FLOAT

implicit none


contains


subroutine mt_initln
!
! The original source code of this subroutine is published here:
! http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/VERSIONS/FORTRAN/mt19937ar.f
!
integer(C_INT) :: ALLBIT_MASK
integer(C_INT) :: TOPBIT_MASK
integer(C_INT) :: UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
integer(C_INT) :: mag01(0:1)
common /mt_mask1/ ALLBIT_MASK
common /mt_mask2/ TOPBIT_MASK
common /mt_mask3/ UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
common /mt_mag01/ mag01
!     TOPBIT_MASK = Z'80000000'
!     ALLBIT_MASK = Z'ffffffff'
!     UPPER_MASK  = Z'80000000'
!     LOWER_MASK  = Z'7fffffff'
!     MATRIX_A    = Z'9908b0df'
!     T1_MASK     = Z'9d2c5680'
!     T2_MASK     = Z'efc60000'
TOPBIT_MASK=1073741824
TOPBIT_MASK=ishft(TOPBIT_MASK,1)
ALLBIT_MASK=2147483647
ALLBIT_MASK=ior(ALLBIT_MASK,TOPBIT_MASK)
UPPER_MASK=TOPBIT_MASK
LOWER_MASK=2147483647
MATRIX_A=419999967
MATRIX_A=ior(MATRIX_A,TOPBIT_MASK)
T1_MASK=489444992
T1_MASK=ior(T1_MASK,TOPBIT_MASK)
T2_MASK=1875247104
T2_MASK=ior(T2_MASK,TOPBIT_MASK)
mag01(0)=0
mag01(1)=MATRIX_A
!
end subroutine mt_initln


subroutine init_genrand(s)
!
! The original source code of the code is published here:
! http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/VERSIONS/FORTRAN/mt19937ar.f
!
integer(C_INT) :: s
integer(C_INT),parameter :: N=624
integer(C_INT),parameter :: DONE=123456789
integer(C_INT) :: ALLBIT_MASK
integer(C_INT) :: mti,initialized
integer(C_INT),dimension(0:N-1) :: mt
common /mt_state1/ mti,initialized
common /mt_state2/ mt
common /mt_mask1/ ALLBIT_MASK
!
call mt_initln
!
mt(0)=iand(s,ALLBIT_MASK)
!
do 100 mti=1,N-1
   mt(mti)=1812433253*&
           ieor(mt(mti-1),ishft(mt(mti-1),-30))+mti
   mt(mti)=iand(mt(mti),ALLBIT_MASK)
!
100 continue
!
initialized=DONE
!
end subroutine init_genrand


function genrand_int32()
!
! The original source code of this subroutine is published here:
! http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/VERSIONS/FORTRAN/mt19937ar.f
!
integer(C_INT) :: genrand_int32
integer(C_INT) :: N,M
integer(C_INT) :: DONE
integer(C_INT) :: UPPER_MASK,LOWER_MASK,MATRIX_A
integer(C_INT) :: T1_MASK,T2_MASK
parameter (N=624)
parameter (M=397)
parameter (DONE=123456789)
integer(C_INT) :: mti,initialized
integer(C_INT),dimension(0:N-1) :: mt
integer(C_INT) :: y,kk
integer(C_INT),dimension(0:1) :: mag01
common /mt_state1/ mti,initialized
common /mt_state2/ mt
common /mt_mask3/ UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
common /mt_mag01/ mag01
!
if(initialized.ne.DONE)then
   call init_genrand(21641)
endif
!
if(mti.ge.N)then
   do 100 kk=0,N-M-1
      y=ior(iand(mt(kk),UPPER_MASK),iand(mt(kk+1),LOWER_MASK))
      mt(kk)=ieor(ieor(mt(kk+M),ishft(y,-1)),mag01(iand(y,1)))
!
100   continue
!
   do 200 kk=N-M,N-1-1
      y=ior(iand(mt(kk),UPPER_MASK),iand(mt(kk+1),LOWER_MASK))
      mt(kk)=ieor(ieor(mt(kk+(M-N)),ishft(y,-1)),mag01(iand(y,1)))
!
200   continue
!
      y=ior(iand(mt(N-1),UPPER_MASK),iand(mt(0),LOWER_MASK))
      mt(kk)=ieor(ieor(mt(M-1),ishft(y,-1)),mag01(iand(y,1)))
      mti=0
end if
!
y=mt(mti)
mti=mti+1
!
y=ieor(y,ishft(y,-11))
y=ieor(y,iand(ishft(y,7),T1_MASK))
y=ieor(y,iand(ishft(y,15),T2_MASK))
y=ieor(y,ishft(y,-18))
!
genrand_int32=y
!
end function genrand_int32


function genrand_real2()
!
! The original source code of this function is published here:
! http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/VERSIONS/FORTRAN/mt19937ar.f
!
real(C_FLOAT) :: genrand_real2
real(C_FLOAT) :: r
!
r=float(genrand_int32())
!
if(r.lt.0.0_C_FLOAT) then
   r=r+2.0_C_FLOAT**32
end if
!
genrand_real2=r/4294967296.0_C_FLOAT
!
end function genrand_real2


end module mod_random

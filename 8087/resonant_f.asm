.model small
.data
RES DD ?
L1 DD 0.0001
C1 DD 47E-6

.code
.startup
mov ax, @data
mov ds,ax
  FINIT
  FLD L1
  FMUL C1
  FSQRT 
  FLDPI
  FADD ST,ST(0)
  FMUL
  FLD1
  FDIVR
  FSTP RES
.exit
end

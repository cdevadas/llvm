; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -fast-isel-abort=3 -mtriple=x86_64-apple-darwin10 | FileCheck %s
; RUN: llc < %s -fast-isel -mtriple=i686-- -mattr=+sse2 | FileCheck --check-prefix=SSE2 %s

define double @doo(double %x) nounwind {
; CHECK-LABEL: doo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    movabsq $-9223372036854775808, %rcx ## imm = 0x8000000000000000
; CHECK-NEXT:    xorq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %xmm0
; CHECK-NEXT:    retq
;
; SSE2-LABEL: doo:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushl %ebp
; SSE2-NEXT:    movl %esp, %ebp
; SSE2-NEXT:    andl $-8, %esp
; SSE2-NEXT:    subl $8, %esp
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movlps %xmm0, (%esp)
; SSE2-NEXT:    fldl (%esp)
; SSE2-NEXT:    movl %ebp, %esp
; SSE2-NEXT:    popl %ebp
; SSE2-NEXT:    retl
  %y = fsub double -0.0, %x
  ret double %y
}

define float @foo(float %x) nounwind {
; CHECK-LABEL: foo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl $2147483648, %eax ## imm = 0x80000000
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    retq
;
; SSE2-LABEL: foo:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushl %eax
; SSE2-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movss %xmm0, (%esp)
; SSE2-NEXT:    flds (%esp)
; SSE2-NEXT:    popl %eax
; SSE2-NEXT:    retl
  %y = fsub float -0.0, %x
  ret float %y
}

define void @goo(double* %x, double* %y) nounwind {
; CHECK-LABEL: goo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    movabsq $-9223372036854775808, %rcx ## imm = 0x8000000000000000
; CHECK-NEXT:    xorq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %xmm0
; CHECK-NEXT:    movq %xmm0, (%rsi)
; CHECK-NEXT:    retq
;
; SSE2-LABEL: goo:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movsd %xmm0, (%eax)
; SSE2-NEXT:    retl
  %a = load double, double* %x
  %b = fsub double -0.0, %a
  store double %b, double* %y
  ret void
}

define void @goo_unary_fneg(double* %x, double* %y) nounwind {
; CHECK-LABEL: goo_unary_fneg:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    movabsq $-9223372036854775808, %rcx ## imm = 0x8000000000000000
; CHECK-NEXT:    xorq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %xmm0
; CHECK-NEXT:    movq %xmm0, (%rsi)
; CHECK-NEXT:    retq
;
; SSE2-LABEL: goo_unary_fneg:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movsd %xmm0, (%eax)
; SSE2-NEXT:    retl
  %a = load double, double* %x
  %b = fneg double %a
  store double %b, double* %y
  ret void
}

define void @loo(float* %x, float* %y) nounwind {
; CHECK-LABEL: loo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl $2147483648, %eax ## imm = 0x80000000
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    movd %xmm0, (%rsi)
; CHECK-NEXT:    retq
;
; SSE2-LABEL: loo:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    movd %xmm0, %ecx
; SSE2-NEXT:    xorl $2147483648, %ecx # imm = 0x80000000
; SSE2-NEXT:    movd %ecx, %xmm0
; SSE2-NEXT:    movd %xmm0, (%eax)
; SSE2-NEXT:    retl
  %a = load float, float* %x
  %b = fsub float -0.0, %a
  store float %b, float* %y
  ret void
}

define void @loo_unary_fneg(float* %x, float* %y) nounwind {
; CHECK-LABEL: loo_unary_fneg:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl $2147483648, %eax ## imm = 0x80000000
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    movd %xmm0, (%rsi)
; CHECK-NEXT:    retq
;
; SSE2-LABEL: loo_unary_fneg:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    movd %xmm0, %ecx
; SSE2-NEXT:    xorl $2147483648, %ecx # imm = 0x80000000
; SSE2-NEXT:    movd %ecx, %xmm0
; SSE2-NEXT:    movd %xmm0, (%eax)
; SSE2-NEXT:    retl
  %a = load float, float* %x
  %b = fneg float %a
  store float %b, float* %y
  ret void
}

define double @too(double %x) nounwind {
; CHECK-LABEL: too:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movq %xmm0, %rax
; CHECK-NEXT:    movabsq $-9223372036854775808, %rcx ## imm = 0x8000000000000000
; CHECK-NEXT:    xorq %rax, %rcx
; CHECK-NEXT:    movq %rcx, %xmm0
; CHECK-NEXT:    retq
;
; SSE2-LABEL: too:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushl %ebp
; SSE2-NEXT:    movl %esp, %ebp
; SSE2-NEXT:    andl $-8, %esp
; SSE2-NEXT:    subl $8, %esp
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movlps %xmm0, (%esp)
; SSE2-NEXT:    fldl (%esp)
; SSE2-NEXT:    movl %ebp, %esp
; SSE2-NEXT:    popl %ebp
; SSE2-NEXT:    retl
  %y = fneg double %x
  ret double %y
}

define float @zoo(float %x) nounwind {
; CHECK-LABEL: zoo:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl $2147483648, %eax ## imm = 0x80000000
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    retq
;
; SSE2-LABEL: zoo:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushl %eax
; SSE2-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    xorps {{\.LCPI.*}}, %xmm0
; SSE2-NEXT:    movss %xmm0, (%esp)
; SSE2-NEXT:    flds (%esp)
; SSE2-NEXT:    popl %eax
; SSE2-NEXT:    retl
  %y = fneg float %x
  ret float %y
}

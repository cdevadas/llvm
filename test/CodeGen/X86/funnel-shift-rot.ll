; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686--   -mattr=sse2 | FileCheck %s --check-prefixes=ANY,X32-SSE2
; RUN: llc < %s -mtriple=x86_64-- -mattr=avx2 | FileCheck %s --check-prefixes=ANY,X64-AVX2

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshl.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

declare i8 @llvm.fshr.i8(i8, i8, i8)
declare i16 @llvm.fshr.i16(i16, i16, i16)
declare i32 @llvm.fshr.i32(i32, i32, i32)
declare i64 @llvm.fshr.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshr.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

; When first 2 operands match, it's a rotate.

define i8 @rotl_i8_const_shift(i8 %x) nounwind {
; X32-SSE2-LABEL: rotl_i8_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-SSE2-NEXT:    rolb $3, %al
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_i8_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    rolb $3, %al
; X64-AVX2-NEXT:    # kill: def $al killed $al killed $eax
; X64-AVX2-NEXT:    retq
  %f = call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 3)
  ret i8 %f
}

define i64 @rotl_i64_const_shift(i64 %x) nounwind {
; X32-SSE2-LABEL: rotl_i64_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-SSE2-NEXT:    movl %ecx, %eax
; X32-SSE2-NEXT:    shldl $3, %edx, %eax
; X32-SSE2-NEXT:    shldl $3, %ecx, %edx
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_i64_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movq %rdi, %rax
; X64-AVX2-NEXT:    rolq $3, %rax
; X64-AVX2-NEXT:    retq
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %x, i64 3)
  ret i64 %f
}

define i16 @rotl_i16(i16 %x, i16 %z) nounwind {
; X32-SSE2-LABEL: rotl_i16:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X32-SSE2-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    rolw %cl, %ax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_i16:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %esi, %ecx
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-AVX2-NEXT:    rolw %cl, %ax
; X64-AVX2-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-AVX2-NEXT:    retq
  %f = call i16 @llvm.fshl.i16(i16 %x, i16 %x, i16 %z)
  ret i16 %f
}

define i32 @rotl_i32(i32 %x, i32 %z) nounwind {
; X32-SSE2-LABEL: rotl_i32:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    roll %cl, %eax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_i32:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %esi, %ecx
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-AVX2-NEXT:    roll %cl, %eax
; X64-AVX2-NEXT:    retq
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 %z)
  ret i32 %f
}

; Vector rotate.

define <4 x i32> @rotl_v4i32(<4 x i32> %x, <4 x i32> %z) nounwind {
; X32-SSE2-LABEL: rotl_v4i32:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    pxor %xmm3, %xmm3
; X32-SSE2-NEXT:    psubd %xmm1, %xmm3
; X32-SSE2-NEXT:    movdqa {{.*#+}} xmm4 = [31,31,31,31]
; X32-SSE2-NEXT:    pand %xmm4, %xmm3
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm2 = xmm3[2,3,3,3,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm5
; X32-SSE2-NEXT:    psrld %xmm2, %xmm5
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm6 = xmm3[0,1,1,1,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm2
; X32-SSE2-NEXT:    psrld %xmm6, %xmm2
; X32-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm5[0]
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[2,3,0,1]
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm5 = xmm3[2,3,3,3,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm6
; X32-SSE2-NEXT:    psrld %xmm5, %xmm6
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm3 = xmm3[0,1,1,1,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm5
; X32-SSE2-NEXT:    psrld %xmm3, %xmm5
; X32-SSE2-NEXT:    punpckhqdq {{.*#+}} xmm5 = xmm5[1],xmm6[1]
; X32-SSE2-NEXT:    shufps {{.*#+}} xmm2 = xmm2[0,3],xmm5[0,3]
; X32-SSE2-NEXT:    pand %xmm4, %xmm1
; X32-SSE2-NEXT:    pslld $23, %xmm1
; X32-SSE2-NEXT:    paddd {{\.LCPI.*}}, %xmm1
; X32-SSE2-NEXT:    cvttps2dq %xmm1, %xmm1
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X32-SSE2-NEXT:    pmuludq %xmm1, %xmm0
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; X32-SSE2-NEXT:    pmuludq %xmm3, %xmm1
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; X32-SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; X32-SSE2-NEXT:    orps %xmm0, %xmm2
; X32-SSE2-NEXT:    movaps %xmm2, %xmm0
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_v4i32:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [31,31,31,31]
; X64-AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm3
; X64-AVX2-NEXT:    vpsllvd %xmm3, %xmm0, %xmm3
; X64-AVX2-NEXT:    vpxor %xmm4, %xmm4, %xmm4
; X64-AVX2-NEXT:    vpsubd %xmm1, %xmm4, %xmm1
; X64-AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; X64-AVX2-NEXT:    vpsrlvd %xmm1, %xmm0, %xmm0
; X64-AVX2-NEXT:    vpor %xmm0, %xmm3, %xmm0
; X64-AVX2-NEXT:    retq
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> %z)
  ret <4 x i32> %f
}

; Vector rotate by constant splat amount.

define <4 x i32> @rotl_v4i32_const_shift(<4 x i32> %x) nounwind {
; X32-SSE2-LABEL: rotl_v4i32_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm1
; X32-SSE2-NEXT:    psrld $29, %xmm1
; X32-SSE2-NEXT:    pslld $3, %xmm0
; X32-SSE2-NEXT:    por %xmm1, %xmm0
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_v4i32_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpsrld $29, %xmm0, %xmm1
; X64-AVX2-NEXT:    vpslld $3, %xmm0, %xmm0
; X64-AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; X64-AVX2-NEXT:    retq
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  ret <4 x i32> %f
}

; Repeat everything for funnel shift right.

define i8 @rotr_i8_const_shift(i8 %x) nounwind {
; X32-SSE2-LABEL: rotr_i8_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-SSE2-NEXT:    rorb $3, %al
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_i8_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    rorb $3, %al
; X64-AVX2-NEXT:    # kill: def $al killed $al killed $eax
; X64-AVX2-NEXT:    retq
  %f = call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 3)
  ret i8 %f
}

define i32 @rotr_i32_const_shift(i32 %x) nounwind {
; X32-SSE2-LABEL: rotr_i32_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    rorl $3, %eax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_i32_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    rorl $3, %eax
; X64-AVX2-NEXT:    retq
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 3)
  ret i32 %f
}

; When first 2 operands match, it's a rotate (by variable amount).

define i16 @rotr_i16(i16 %x, i16 %z) nounwind {
; X32-SSE2-LABEL: rotr_i16:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X32-SSE2-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    rorw %cl, %ax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_i16:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %esi, %ecx
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-AVX2-NEXT:    rorw %cl, %ax
; X64-AVX2-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-AVX2-NEXT:    retq
  %f = call i16 @llvm.fshr.i16(i16 %x, i16 %x, i16 %z)
  ret i16 %f
}

define i64 @rotr_i64(i64 %x, i64 %z) nounwind {
; X32-SSE2-LABEL: rotr_i64:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    pushl %ebp
; X32-SSE2-NEXT:    pushl %ebx
; X32-SSE2-NEXT:    pushl %edi
; X32-SSE2-NEXT:    pushl %esi
; X32-SSE2-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-SSE2-NEXT:    movl %edx, %edi
; X32-SSE2-NEXT:    shrl %cl, %edi
; X32-SSE2-NEXT:    movl %esi, %ebx
; X32-SSE2-NEXT:    shrdl %cl, %edx, %ebx
; X32-SSE2-NEXT:    xorl %ebp, %ebp
; X32-SSE2-NEXT:    testb $32, %cl
; X32-SSE2-NEXT:    cmovnel %edi, %ebx
; X32-SSE2-NEXT:    cmovnel %ebp, %edi
; X32-SSE2-NEXT:    negb %cl
; X32-SSE2-NEXT:    movl %esi, %eax
; X32-SSE2-NEXT:    shll %cl, %eax
; X32-SSE2-NEXT:    shldl %cl, %esi, %edx
; X32-SSE2-NEXT:    testb $32, %cl
; X32-SSE2-NEXT:    cmovnel %eax, %edx
; X32-SSE2-NEXT:    cmovnel %ebp, %eax
; X32-SSE2-NEXT:    orl %ebx, %eax
; X32-SSE2-NEXT:    orl %edi, %edx
; X32-SSE2-NEXT:    popl %esi
; X32-SSE2-NEXT:    popl %edi
; X32-SSE2-NEXT:    popl %ebx
; X32-SSE2-NEXT:    popl %ebp
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_i64:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movq %rsi, %rcx
; X64-AVX2-NEXT:    movq %rdi, %rax
; X64-AVX2-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-AVX2-NEXT:    rorq %cl, %rax
; X64-AVX2-NEXT:    retq
  %f = call i64 @llvm.fshr.i64(i64 %x, i64 %x, i64 %z)
  ret i64 %f
}

; Vector rotate.

define <4 x i32> @rotr_v4i32(<4 x i32> %x, <4 x i32> %z) nounwind {
; X32-SSE2-LABEL: rotr_v4i32:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [31,31,31,31]
; X32-SSE2-NEXT:    pxor %xmm3, %xmm3
; X32-SSE2-NEXT:    psubd %xmm1, %xmm3
; X32-SSE2-NEXT:    movdqa %xmm1, %xmm4
; X32-SSE2-NEXT:    pand %xmm2, %xmm4
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm1 = xmm4[2,3,3,3,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm5
; X32-SSE2-NEXT:    psrld %xmm1, %xmm5
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm6 = xmm4[0,1,1,1,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm1
; X32-SSE2-NEXT:    psrld %xmm6, %xmm1
; X32-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm5[0]
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[2,3,0,1]
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm5 = xmm4[2,3,3,3,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm6
; X32-SSE2-NEXT:    psrld %xmm5, %xmm6
; X32-SSE2-NEXT:    pshuflw {{.*#+}} xmm4 = xmm4[0,1,1,1,4,5,6,7]
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm5
; X32-SSE2-NEXT:    psrld %xmm4, %xmm5
; X32-SSE2-NEXT:    punpckhqdq {{.*#+}} xmm5 = xmm5[1],xmm6[1]
; X32-SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,3],xmm5[0,3]
; X32-SSE2-NEXT:    pand %xmm2, %xmm3
; X32-SSE2-NEXT:    pslld $23, %xmm3
; X32-SSE2-NEXT:    paddd {{\.LCPI.*}}, %xmm3
; X32-SSE2-NEXT:    cvttps2dq %xmm3, %xmm2
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; X32-SSE2-NEXT:    pmuludq %xmm2, %xmm0
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,1,3,3]
; X32-SSE2-NEXT:    pmuludq %xmm3, %xmm2
; X32-SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[0,2,2,3]
; X32-SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; X32-SSE2-NEXT:    orps %xmm0, %xmm1
; X32-SSE2-NEXT:    movaps %xmm1, %xmm0
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_v4i32:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [31,31,31,31]
; X64-AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm3
; X64-AVX2-NEXT:    vpsrlvd %xmm3, %xmm0, %xmm3
; X64-AVX2-NEXT:    vpxor %xmm4, %xmm4, %xmm4
; X64-AVX2-NEXT:    vpsubd %xmm1, %xmm4, %xmm1
; X64-AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; X64-AVX2-NEXT:    vpsllvd %xmm1, %xmm0, %xmm0
; X64-AVX2-NEXT:    vpor %xmm3, %xmm0, %xmm0
; X64-AVX2-NEXT:    retq
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> %z)
  ret <4 x i32> %f
}

; Vector rotate by constant splat amount.

define <4 x i32> @rotr_v4i32_const_shift(<4 x i32> %x) nounwind {
; X32-SSE2-LABEL: rotr_v4i32_const_shift:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movdqa %xmm0, %xmm1
; X32-SSE2-NEXT:    psrld $3, %xmm1
; X32-SSE2-NEXT:    pslld $29, %xmm0
; X32-SSE2-NEXT:    por %xmm1, %xmm0
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_v4i32_const_shift:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    vpsrld $3, %xmm0, %xmm1
; X64-AVX2-NEXT:    vpslld $29, %xmm0, %xmm0
; X64-AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; X64-AVX2-NEXT:    retq
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  ret <4 x i32> %f
}

define i32 @rotl_i32_shift_by_bitwidth(i32 %x) nounwind {
; X32-SSE2-LABEL: rotl_i32_shift_by_bitwidth:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotl_i32_shift_by_bitwidth:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    retq
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 32)
  ret i32 %f
}

define i32 @rotr_i32_shift_by_bitwidth(i32 %x) nounwind {
; X32-SSE2-LABEL: rotr_i32_shift_by_bitwidth:
; X32-SSE2:       # %bb.0:
; X32-SSE2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-SSE2-NEXT:    retl
;
; X64-AVX2-LABEL: rotr_i32_shift_by_bitwidth:
; X64-AVX2:       # %bb.0:
; X64-AVX2-NEXT:    movl %edi, %eax
; X64-AVX2-NEXT:    retq
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 32)
  ret i32 %f
}

define <4 x i32> @rotl_v4i32_shift_by_bitwidth(<4 x i32> %x) nounwind {
; ANY-LABEL: rotl_v4i32_shift_by_bitwidth:
; ANY:       # %bb.0:
; ANY-NEXT:    ret{{[l|q]}}
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

define <4 x i32> @rotr_v4i32_shift_by_bitwidth(<4 x i32> %x) nounwind {
; ANY-LABEL: rotr_v4i32_shift_by_bitwidth:
; ANY:       # %bb.0:
; ANY-NEXT:    ret{{[l|q]}}
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

; Non power-of-2 types can't use the negated shift amount to avoid a select.

declare i7 @llvm.fshl.i7(i7, i7, i7)
declare i7 @llvm.fshr.i7(i7, i7, i7)

; extract(concat(0b1110000, 0b1110000) << 9) = 0b1000011
; Try an oversized shift to test modulo functionality.

define i7 @fshl_i7() {
; ANY-LABEL: fshl_i7:
; ANY:       # %bb.0:
; ANY-NEXT:    movb $67, %al
; ANY-NEXT:    ret{{[l|q]}}
  %f = call i7 @llvm.fshl.i7(i7 112, i7 112, i7 9)
  ret i7 %f
}

; extract(concat(0b1110001, 0b1110001) >> 16) = 0b0111100
; Try an oversized shift to test modulo functionality.

define i7 @fshr_i7() {
; ANY-LABEL: fshr_i7:
; ANY:       # %bb.0:
; ANY-NEXT:    movb $60, %al
; ANY-NEXT:    ret{{[l|q]}}
  %f = call i7 @llvm.fshr.i7(i7 113, i7 113, i7 16)
  ret i7 %f
}


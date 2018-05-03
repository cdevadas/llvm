; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=x86-64 -mattr=+3dnowa | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC

define void @test_femms() optsize {
; CHECK-LABEL: test_femms:
; CHECK:       # %bb.0:
; CHECK-NEXT:    femms # sched: [100:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  call void @llvm.x86.mmx.femms()
  ret void
}
declare void @llvm.x86.mmx.femms() nounwind readnone

define i64 @test_pavgusb(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pavgusb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pavgusb %mm1, %mm0 # sched: [5:1.00]
; CHECK-NEXT:    pavgusb (%rdi), %mm0 # sched: [11:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pavgusb(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pavgusb(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pavgusb(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pf2id(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pf2id:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pf2id (%rdi), %mm0 # sched: [8:1.00]
; CHECK-NEXT:    pf2id %mm0, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnow.pf2id(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnow.pf2id(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pf2id(x86_mmx) nounwind readnone

define i64 @test_pf2iw(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pf2iw:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pf2iw (%rdi), %mm0 # sched: [8:1.00]
; CHECK-NEXT:    pf2iw %mm0, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnowa.pf2iw(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnowa.pf2iw(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnowa.pf2iw(x86_mmx) nounwind readnone

define i64 @test_pfacc(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfacc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfacc %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfacc (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfacc(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfacc(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfacc(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfadd(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfadd %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfadd (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfadd(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfadd(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfadd(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfcmpeq(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfcmpeq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfcmpeq %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfcmpeq (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfcmpeq(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfcmpeq(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfcmpeq(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfcmpge(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfcmpge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfcmpge %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfcmpge (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfcmpge(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfcmpge(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfcmpge(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfcmpgt(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfcmpgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfcmpgt %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfcmpgt (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfcmpgt(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfcmpgt(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfcmpgt(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfmax(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfmax %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfmax (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfmax(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfmax(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfmax(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfmin(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfmin %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfmin (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfmin(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfmin(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfmin(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfmul(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfmul:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfmul %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfmul (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfmul(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfmul(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfmul(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfnacc(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfnacc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfnacc %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfnacc (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnowa.pfnacc(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnowa.pfnacc(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnowa.pfnacc(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfpnacc(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfpnacc:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfpnacc %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfpnacc (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnowa.pfpnacc(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnowa.pfpnacc(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnowa.pfpnacc(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfrcp(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pfrcp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfrcp (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    pfrcp %mm0, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnow.pfrcp(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnow.pfrcp(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfrcp(x86_mmx) nounwind readnone

define i64 @test_pfrcpit1(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfrcpit1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfrcpit1 %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfrcpit1 (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfrcpit1(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfrcpit1(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfrcpit1(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfrcpit2(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfrcpit2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfrcpit2 %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfrcpit2 (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfrcpit2(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfrcpit2(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfrcpit2(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfrsqit1(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfrsqit1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfrsqit1 %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfrsqit1 (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfrsqit1(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfrsqit1(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfrsqit1(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfrsqrt(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pfrsqrt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfrsqrt (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    pfrsqrt %mm0, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnow.pfrsqrt(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnow.pfrsqrt(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfrsqrt(x86_mmx) nounwind readnone

define i64 @test_pfsub(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfsub:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfsub %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfsub (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfsub(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfsub(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfsub(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pfsubr(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pfsubr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pfsubr %mm1, %mm0 # sched: [3:1.00]
; CHECK-NEXT:    pfsubr (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pfsubr(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pfsubr(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pfsubr(x86_mmx, x86_mmx) nounwind readnone

define i64 @test_pi2fd(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pi2fd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pi2fd (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    pi2fd %mm0, %mm0 # sched: [4:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnow.pi2fd(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnow.pi2fd(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pi2fd(x86_mmx) nounwind readnone

define i64 @test_pi2fw(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pi2fw:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pi2fw (%rdi), %mm0 # sched: [9:1.00]
; CHECK-NEXT:    pi2fw %mm0, %mm0 # sched: [4:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnowa.pi2fw(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnowa.pi2fw(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnowa.pi2fw(x86_mmx) nounwind readnone

define i64 @test_pmulhrw(x86_mmx %a0, x86_mmx %a1, x86_mmx* %a2) optsize {
; CHECK-LABEL: test_pmulhrw:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pmulhrw %mm1, %mm0 # sched: [5:1.00]
; CHECK-NEXT:    pmulhrw (%rdi), %mm0 # sched: [11:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = call x86_mmx @llvm.x86.3dnow.pmulhrw(x86_mmx %a0, x86_mmx %a1)
  %2 = load x86_mmx, x86_mmx *%a2, align 8
  %3 = call x86_mmx @llvm.x86.3dnow.pmulhrw(x86_mmx %1, x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnow.pmulhrw(x86_mmx, x86_mmx) nounwind readnone

define void @test_prefetch(i8* %a0) optsize {
; CHECK-LABEL: test_prefetch:
; CHECK:       # %bb.0:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    prefetch (%rdi) # sched: [5:0.50]
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    retq # sched: [1:1.00]
  tail call void asm sideeffect "prefetch $0", "*m"(i8 *%a0) nounwind
  ret void
}

define void @test_prefetchw(i8* %a0) optsize {
; CHECK-LABEL: test_prefetchw:
; CHECK:       # %bb.0:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    prefetchw (%rdi) # sched: [5:0.50]
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    retq # sched: [1:1.00]
  tail call void asm sideeffect "prefetchw $0", "*m"(i8 *%a0) nounwind
  ret void
}

define i64 @test_pswapd(x86_mmx* %a0) optsize {
; CHECK-LABEL: test_pswapd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pswapd (%rdi), %mm0 # mm0 = mem[1,0] sched: [6:1.00]
; CHECK-NEXT:    pswapd %mm0, %mm0 # mm0 = mm0[1,0] sched: [1:1.00]
; CHECK-NEXT:    movq %mm0, %rax # sched: [1:0.33]
; CHECK-NEXT:    retq # sched: [1:1.00]
  %1 = load x86_mmx, x86_mmx *%a0, align 8
  %2 = call x86_mmx @llvm.x86.3dnowa.pswapd(x86_mmx %1)
  %3 = call x86_mmx @llvm.x86.3dnowa.pswapd(x86_mmx %2)
  %4 = bitcast x86_mmx %3 to i64
  ret i64 %4
}
declare x86_mmx @llvm.x86.3dnowa.pswapd(x86_mmx) nounwind readnone

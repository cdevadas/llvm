//===--------------------- ResourcePressureView.h ---------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
/// \file
///
/// This file define class ResourcePressureView.
/// Class ResourcePressureView observes hardware events generated by
/// the Backend object and collects statistics related to resource usage at
/// instruction granularity.
/// Resource pressure information is then printed out to a stream in the
/// form of a table like the one from the example below:
///
/// Resources:
/// [0] - JALU0
/// [1] - JALU1
/// [2] - JDiv
/// [3] - JFPM
/// [4] - JFPU0
/// [5] - JFPU1
/// [6] - JLAGU
/// [7] - JSAGU
/// [8] - JSTC
/// [9] - JVIMUL
///
/// Resource pressure per iteration:
/// [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]
/// 0.00   0.00   0.00   0.00   2.00   2.00   0.00   0.00   0.00   0.00
///
/// Resource pressure by instruction:
/// [0]  [1]  [2]  [3]  [4]  [5]  [6]  [7]  [8]  [9]  Instructions:
///  -    -    -    -    -   1.00  -    -    -    -   vpermilpd  $1,    %xmm0,
///  %xmm1
///  -    -    -    -   1.00  -    -    -    -    -   vaddps     %xmm0, %xmm1,
///  %xmm2
///  -    -    -    -    -   1.00  -    -    -    -   vmovshdup  %xmm2, %xmm3
///  -    -    -    -   1.00  -    -    -    -    -   vaddss     %xmm2, %xmm3,
///  %xmm4
///
/// In this example, we have AVX code executed on AMD Jaguar (btver2).
/// Both shuffles and vector floating point add operations on XMM registers have
/// a reciprocal throughput of 1cy.
/// Each add is issued to pipeline JFPU0, while each shuffle is issued to
/// pipeline JFPU1. The overall pressure per iteration is reported by two
/// tables: the first smaller table is the resource pressure per iteration;
/// the second table reports resource pressure per instruction. Values are the
/// average resource cycles consumed by an instruction.
/// Every vector add from the example uses resource JFPU0 for an average of 1cy
/// per iteration. Consequently, the resource pressure on JFPU0 is of 2cy per
/// iteration.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_TOOLS_LLVM_MCA_RESOURCEPRESSUREVIEW_H
#define LLVM_TOOLS_LLVM_MCA_RESOURCEPRESSUREVIEW_H

#include "SourceMgr.h"
#include "View.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/MC/MCInstPrinter.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include <map>

namespace mca {

class Backend;

/// This class collects resource pressure statistics and it is able to print
/// out all the collected information as a table to an output stream.
class ResourcePressureView : public View {
  const llvm::MCSubtargetInfo &STI;
  llvm::MCInstPrinter &MCIP;
  const SourceMgr &Source;

  // Map to quickly obtain the ResourceUsage column index from a processor
  // resource ID.
  llvm::DenseMap<unsigned, unsigned> Resource2VecIndex;

  // Table of resources used by instructions.
  std::vector<unsigned> ResourceUsage;
  unsigned NumResourceUnits;

  const llvm::MCInst &GetMCInstFromIndex(unsigned Index) const;
  void printResourcePressurePerIteration(llvm::raw_ostream &OS,
                                         unsigned Executions) const;
  void printResourcePressurePerInstruction(llvm::raw_ostream &OS,
                                           unsigned Executions) const;
  void initialize();

public:
  ResourcePressureView(const llvm::MCSubtargetInfo &sti,
                       llvm::MCInstPrinter &Printer, const SourceMgr &SM)
      : STI(sti), MCIP(Printer), Source(SM) {
    initialize();
  }

  void onInstructionEvent(const HWInstructionEvent &Event) override;

  void printView(llvm::raw_ostream &OS) const override {
    unsigned Executions = Source.getNumIterations();
    printResourcePressurePerIteration(OS, Executions);
    printResourcePressurePerInstruction(OS, Executions);
  }
};

} // namespace mca

#endif

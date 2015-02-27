; RUN: opt %loadPolly -polly-detect-unprofitable -pass-remarks-missed="polly-detect" -polly-detect-track-failures -polly-detect -analyze < %s 2>&1| FileCheck %s

; void f(int A[]) {
;   for(int i=0; i<42; ++i)
;     A[i*i] = 0;
; }


; CHECK: remark: ReportNonAffineAccess-01.c:2:7: The following errors keep this region from being a Scop.
; CHECK: remark: ReportNonAffineAccess-01.c:3:5: The array subscript of "A" is not affine
; CHECK: remark: ReportNonAffineAccess-01.c:3:5: Invalid Scop candidate ends here.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @f(i32* %A) {
entry:
  br label %entry.split

entry.split:                                      ; preds = %entry
  tail call void @llvm.dbg.value(metadata i32* %A, i64 0, metadata !13), !dbg !14
  tail call void @llvm.dbg.value(metadata i32 0, i64 0, metadata !16), !dbg !18
  br label %for.body, !dbg !19

for.body:                                         ; preds = %entry.split, %for.body
  %0 = phi i32 [ 0, %entry.split ], [ %1, %for.body ], !dbg !20
  %mul = mul nsw i32 %0, %0, !dbg !20
  %idxprom1 = zext i32 %mul to i64, !dbg !20
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %idxprom1, !dbg !20
  store i32 0, i32* %arrayidx, align 4, !dbg !20
  %1 = add nsw i32 %0, 1, !dbg !21
  tail call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !16), !dbg !18
  %exitcond = icmp ne i32 %1, 42, !dbg !19
  br i1 %exitcond, label %for.body, label %for.end, !dbg !19

for.end:                                          ; preds = %for.body
  ret void, !dbg !22
}

declare void @llvm.dbg.declare(metadata, metadata)

declare void @llvm.dbg.value(metadata, i64, metadata)

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!10, !11}
!llvm.ident = !{!12}

!0 = !{!"0x11\0012\00clang version 3.6.0 \000\00\000\00\001", !1, !2, !2, !3, !2, !2} ; [ DW_TAG_compile_unit ] [test/ScopDetectionDiagnostic/ReportNonAffineAccess-01.c] [DW_LANG_C99]
!1 = !{!"ReportNonAffineAccess-01.c", !"test/ScopDetectionDiagnostic/"}
!2 = !{}
!3 = !{!4}
!4 = !{!"0x2e\00f\00f\00\001\000\001\000\006\00256\000\001", !1, !5, !6, null, void (i32*)* @f, null, null, !2} ; [ DW_TAG_subprogram ] [line 1] [def] [f]
!5 = !{!"0x29", !1}          ; [ DW_TAG_file_type ] [test/ScopDetectionDiagnostic/ReportNonAffineAccess-01.c]
!6 = !{!"0x15\00\000\000\000\000\000\000", i32 0, null, null, !7, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = !{null, !8}
!8 = !{!"0xf\00\000\0064\0064\000\000", null, null, !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!9 = !{!"0x24\00int\000\0032\0032\000\000\005", null, null} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 2}
!12 = !{!"clang version 3.6.0 "}
!13 = !{!"0x101\00A\0016777217\000", !4, !5, !8} ; [ DW_TAG_arg_variable ] [A] [line 1]
!14 = !MDLocation(line: 1, column: 12, scope: !4)
!15 = !{i32 0}
!16 = !{!"0x100\00i\002\000", !17, !5, !9} ; [ DW_TAG_auto_variable ] [i] [line 2]
!17 = !{!"0xb\002\003\000", !1, !4} ; [ DW_TAG_lexical_block ] [test/ScopDetectionDiagnostic/ReportNonAffineAccess-01.c]
!18 = !MDLocation(line: 2, column: 11, scope: !17)
!19 = !MDLocation(line: 2, column: 7, scope: !17)
!20 = !MDLocation(line: 3, column: 5, scope: !17)
!21 = !MDLocation(line: 2, column: 22, scope: !17)
!22 = !MDLocation(line: 4, column: 1, scope: !4)

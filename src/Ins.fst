module Ins

open Regs
open State
open Operand
open Types

(*
let add64_seman (dst : t1) (src : t2) [|operand nat64 t1|] [|operand nat64 t2|] : st unit =
    s <-- get;
    let r = (eval dst s + eval src s) % pow2_64 in
    update dst r

[@(tac_postprocess tau)]
*)

type add64 't1 't2 = {
  dst: 't1;
  src: 't2;
  dst_operand: operand nat64 't1;
  src_operand: operand nat64 't2
}

val eval_add64 : add64 't1 't2 -> st unit
let eval_add64 i =
  s <-- get;
  let sum = (i.dst_operand.eval_operand i.dst s + i.src_operand.eval_operand i.src s) % pow2_64 in
  i.dst_operand.update_operand i.dst sum

val add64_to_string : [|show t1, show t2|] -> add64 't1 't2 -> string
let add64_to_string t = "addf64 "a ^ show t.dst ^ " " ^ show t.src

let add64_ins (#t1:Type)(#t2:Type) : ins (add64 t1 t2) = {
  eval_ins = eval_add64;
  ins_to_string = add64_to_string #t1 #t2
}

noeq type paddd 't1 't2 = {
  dst: 't1;
  src: 't2;
  dst_operand: operand quad32 't1;
  src_operand: operand quad32 't2
}

val eval_paddd : paddd 't1 't2 -> st unit
let eval_paddd i =
  s <-- get;
  let src_q = i.src_operand.eval_operand i.src s in
  let dst_q = i.dst_operand.eval_operand i.dst s in
  i.dst_operand.update_operand i.dst (Mkfour ((dst_q.lo0 + src_q.lo0) % pow2_32)
                                             ((dst_q.lo1 + src_q.lo1) % pow2_32)
                                             ((dst_q.hi2 + src_q.hi2) % pow2_32)
                                             ((dst_q.hi3 + src_q.hi3) % pow2_32))

val paddd_to_string : paddd 't1 't2 -> string
let paddd_to_string _ = ""

let paddd_ins (#t1:Type)(#t2:Type): ins (paddd t1 t2) = {
  eval_ins = eval_paddd;
  ins_to_string = paddd_to_string #t1 #t2
}

noeq type mulx64 't1 't2 't3 = {
  dst_hi : 't1;
  dst_lo : 't2;
  src    : 't3;
  dst_hi_operand : operand nat64 't1;
  dst_lo_operand : operand nat64 't2;
  src_operand    : operand nat64 't3
}

val eval_mulx64 : mulx64 't1 't2 't3 -> st unit
let eval_mulx64 i =
  s <-- get;
  let hi = FStar.UInt.mul_div #64 (s.regs gReg rdx) (i.src_operand.eval_operand i.src s) in
  let lo = FStar.UInt.mul_mod #64 (s.regs gReg rdx) (i.src_operand.eval_operand i.src s) in
  i.dst_lo_operand.update_operand i.dst_lo lo ;;
  i.dst_hi_operand.update_operand i.dst_hi hi

val mulx64_to_string : mulx64 't1 't2 't3 -> string
let mulx64_to_string _ = ""

let mulx64_ins (#t1:Type)(#t2:Type)(#t3:Type) : ins (mulx64 t1 t2 t3) = {
  eval_ins = eval_mulx64;
  ins_to_string = mulx64_to_string #t1 #t2 #t3
}

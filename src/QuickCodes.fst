module QuickCodes

open Regs
open State
open QuickCode
open FStar.List

let rec regs_list_match (#t:reg_t) (regs: list (regtyp t)) (r0:regmap) (r1:regmap) : Type0 =
match regs with
| [] -> True
| r::regs' -> r0 t r == r1 t r /\ regs_list_match regs' r0 r1

let rec regs_class_match (regs: list reg_t) (r0:regmap) (r1:regmap) : Type0 =
match regs with
| [] -> True
| t::regs' -> regs_list_match (reglist t) r0 r1 /\ regs_class_match regs' r0 r1

let regs_match (r0:regmap) (r1:regmap) : Type0 =
  regs_class_match regclasses r0 r1

let va_state_match (s0:state) (s1:state) : Pure Type0
    (requires True)
    (ensures fun b -> b ==> state_eq s0 s1) =
    s0.ok == s1.ok /\
    regs_match s0.regs s1.regs

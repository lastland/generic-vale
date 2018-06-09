module Regs

open FStar.FunctionalExtensionality

type reg_t = n:int{0 <= n /\ n <= 1}

type reg =
  | Rax
  | Rbx
  | Rcx
  | Rdx
  | Rsi
  | Rdi
  | Rbp
  | Rsp
  | R8
  | R9
  | R10
  | R11
  | R12
  | R13
  | R14
  | R15

let list_reg = [Rax; Rbx; Rcx; Rdx; Rsi; Rdi; Rbp; Rsp; R8; R9; R10; R11; R12; R13; R14; R15]

type xmm = i:int{ 0 <= i /\ i < 16 }

let list_xmm : list xmm = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15]

let regtyp (t:reg_t) : Type =
  match t with
  | 0 -> reg
  | 1 -> xmm

(* wrong definition, use for convenience right now *)
type nat32=n:int{0 <= n /\ n < 32}
type nat64=n:int{0 <= n /\ n < 64}
type quad32=(nat32 * nat32 * nat32 * nat32)

let regval t =
  match t with
  | 0 -> nat64
  | 1 -> quad32

let reglist t =
  match t with
  | 0 -> list_reg
  | 1 -> list_xmm

let regclasses = [0; 1]

let equal regs1 regs2 = feq regs1 regs2
let lemma_equal_intro regs1 regs2 = ()
let lemma_equal_elim regs1 regs2 = ()

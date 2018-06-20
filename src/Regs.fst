module Regs

open Types
open FStar.FunctionalExtensionality

let n_reg_t : n:nat{0 < n} = 2

let gReg : reg_t = 0
let mReg : reg_t = 1

let n_regtype _ : n:nat{0 < n} = 16

let regval n =
  if n = 0 then nat64 else quad32

let rax : regtyp gReg = 0
let rbx : regtyp gReg = 1
let rcx : regtyp gReg = 2
let rdx : regtyp gReg = 3
let rsp : regtyp gReg = 7

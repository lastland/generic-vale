module Regs

open Types
open FStar.FunctionalExtensionality

let n_reg_t : n:nat{0 < n} = 2

let n_regtype _ : n:nat{0 < n} = 16

let regval n =
  if n = 0 then nat64 else quad32

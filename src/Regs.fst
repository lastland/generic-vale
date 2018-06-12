module Regs

open FStar.FunctionalExtensionality

let n_reg_t : n:nat{0 < n} = 2

let n_regtype _ : n:nat{0 < n} = 16

let regval _ = nat

let equal1 #_ f1 f2 = feq f1 f2

let equal f1 f2 = forall t. equal1 (f1 t) (f2 t)

let lemma_equal1_intro t regs1 regs2 = ()

let lemma_equal1_elim t regs1 regs2 = ()

let lemma_equal_intro regs1 regs2 = ()

let lemma_equal_elim regs1 regs2 = ()
module Regs

open FStar.List

val reg_t : eqtype

val regtyp : reg_t -> eqtype

val regval : reg_t -> eqtype

val reglist : t:reg_t -> list (regtyp t)

val regclasses : list (reg_t)

type regmap = t:reg_t -> regtyp t -> regval t

val equal : regmap -> regmap -> Type0

val equal1 : t:reg_t -> (regtyp t -> regval t) -> (regtyp t -> regval t) -> Type0

val lemma_reglist_complete (t:reg_t) : r:regtyp t -> Lemma
  (requires True)
  (ensures mem r (reglist t) == true)
  [SMTPat (mem r (reglist t) == true)]

val lemma_regclasses_complete : t:reg_t -> Lemma
  (requires True)
  (ensures mem t regclasses == true)
  [SMTPat (mem t regclasses == true)]

val lemma_equal1_intro : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires forall r. regs1 t r == regs2 t r)
  (ensures equal1 t (regs1 t) (regs2 t))
  [SMTPat (equal1 t (regs1 t) (regs2 t))]

val lemma_equal1_elim : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires equal1 t (regs1 t) (regs2 t))
  (ensures regs1 t == regs2 t)
  [SMTPat (equal1 t (regs1 t) (regs2 t))]

val lemma_equal_intro : regs1:regmap -> regs2:regmap -> Lemma
  (requires forall t. regs1 t == regs2 t)
  (ensures equal regs1 regs2)
  [SMTPat (equal regs1 regs2)]

val lemma_equal_elim : regs1:regmap -> regs2:regmap -> Lemma
  (requires equal regs1 regs2)
  (ensures regs1 == regs2)
  [SMTPat (equal regs1 regs2)]

module Regs

open FStar.List
open Util

val n_reg_t : pos

type reg_t = n:nat{n < n_reg_t}

let regclasses : list reg_t = range n_reg_t

let lemma_regclasses_complete : unit -> Lemma
	(forall (t:reg_t). mem t regclasses) = fun _ ->
	lemma_range_complete n_reg_t;
	assert (forall (t:reg_t). t < n_reg_t)

let lemma_regclasses_derive : p:(reg_t -> Type0) -> Lemma
	((forall t0. mem t0 regclasses ==> p t0) ==> (forall t. p t)) = fun _ ->
	lemma_regclasses_complete ()

val n_regtype : reg_t -> pos

unfold type regtyp (t:reg_t) = n:nat{n < n_regtype t}

(* why [list (regtyp t)] does not work here? *)
let reglist (t:reg_t) : list (n:nat{n < n_regtype t}) = range (n_regtype t)

let lemma_reglist_complete : t:reg_t -> Lemma
	(forall (r:regtyp t). mem r (reglist t)) = fun t ->
	lemma_range_complete (n_regtype t)

let lemma_reglist_derive : #t:reg_t -> p:(regtyp t -> Type0) -> Lemma
	((forall r0. mem r0 (reglist t) ==> p r0) ==> (forall r. p r)) = fun #t p ->
	lemma_reglist_complete t

val regval : reg_t -> Type0


type regmap = t:reg_t -> regtyp t -> regval t

val equal1 : #t:reg_t -> (regtyp t -> regval t) -> (regtyp t -> regval t) -> Type0

val equal : regmap -> regmap -> Type0

val lemma_equal1_intro : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires forall r. regs1 t r == regs2 t r)
  (ensures equal1 (regs1 t) (regs2 t))
  [SMTPat (equal1 (regs1 t) (regs2 t))]

val lemma_equal1_elim : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires equal1 (regs1 t) (regs2 t))
  (ensures regs1 t == regs2 t)
  [SMTPat (equal1 (regs1 t) (regs2 t))]

val lemma_equal_intro : regs1:regmap -> regs2:regmap -> Lemma
  (requires forall t. regs1 t == regs2 t)
  (ensures equal regs1 regs2)
  [SMTPat (equal regs1 regs2)]

val lemma_equal_elim : regs1:regmap -> regs2:regmap -> Lemma
  (requires equal regs1 regs2)
  (ensures regs1 == regs2)
  [SMTPat (equal regs1 regs2)]

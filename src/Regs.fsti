module Regs

open FStar.List
open FStar.FunctionalExtensionality
open Util

val n_reg_t : pos

type reg_t = n:nat{n < n_reg_t}

let regclasses : list reg_t = range n_reg_t

let lemma_regclasses_complete : unit -> Lemma
  (forall (t:reg_t). mem t regclasses) = fun _ ->
    assert (forall (t:reg_t). t < n_reg_t);
    FStar.Classical.forall_intro(lemma_range_complete n_reg_t)

let lemma_regclasses_derive : p:(reg_t -> Type0) -> Lemma
  ((forall t0. mem t0 regclasses ==> p t0) ==> (forall t. p t)) = fun _ ->
    lemma_regclasses_complete ()

val n_regtype : reg_t -> pos

type regtyp (t:reg_t) = n:nat{n < n_regtype t}

(* why [list (regtyp t)] does not work here? *)
let reglist (t:reg_t) : list (regtyp t) = range (n_regtype t)

let lemma_reglist_complete : t:reg_t -> Lemma
  (forall (r:regtyp t). mem r (reglist t)) = fun t ->
    FStar.Classical.forall_intro(lemma_range_complete (n_regtype t))

let lemma_reglist_derive : #t:reg_t -> p:(regtyp t -> Type0) -> Lemma
  ((forall r0. mem r0 (reglist t) ==> p r0) ==> (forall r. p r)) = fun #t p ->
    lemma_reglist_complete t

val regval : reg_t -> Type0


type regmap = t:reg_t -> regtyp t -> regval t

let update_regmap (t:reg_t) (r:regtyp t) (v:regval t) (old:regmap): regmap =
  (fun t' -> if t' = t then
    (let f : regtyp t -> regval t =
      fun r' -> if r' = r then v else (old t' r') in f)
      else (old t'))

let equal1 (#t:reg_t)(regs1:regtyp t -> regval t)(regs2:regtyp t -> regval t) : Type0 =
  feq regs1 regs2

let equal (regs1:regmap)(regs2:regmap) : Type0 =
  forall t. equal1 #t (regs1 t) (regs2 t)

let lemma_equal1_intro : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires forall r. regs1 t r == regs2 t r)
  (ensures equal1 (regs1 t) (regs2 t))
  [SMTPat (equal1 (regs1 t) (regs2 t))] = fun _ _ _ -> ()

let lemma_equal1_elim : t:reg_t -> regs1:regmap -> regs2:regmap -> Lemma
  (requires equal1 #t (regs1 t) (regs2 t))
  (ensures regs1 t == regs2 t)
  [SMTPat (equal1 (regs1 t) (regs2 t))] = fun _ _ _ -> ()

let lemma_equal_intro : regs1:regmap -> regs2:regmap -> Lemma
  (requires forall t. regs1 t == regs2 t)
  (ensures equal regs1 regs2)
  [SMTPat (equal regs1 regs2)] = fun _ _ -> ()

let lemma_equal_elim : regs1:regmap -> regs2:regmap -> Lemma
  (requires equal regs1 regs2)
  (ensures regs1 == regs2)
  [SMTPat (equal regs1 regs2)] = fun regs1 regs2 ->
  assert (equal regs1 regs2 ==> (forall t. regs1 t == regs2 t));
  admit() (* help needed *)

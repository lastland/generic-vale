module QuickCodes

open Regs
open State
open QuickCode
open FStar.List

(** * Comparing [reglist] *)

let rec regs_list_match (#t:reg_t) (regs: list (n:nat{n < n_regtype t})) (r0:regmap) (r1:regmap) : Type0 =
match regs with
| [] -> True
| r::regs' -> r0 t r == r1 t r /\ regs_list_match regs' r0 r1

unfold
let reglist_match (t:reg_t)(r0:regmap)(r1:regmap) : Type0 =
	regs_list_match (reglist t) r0 r1

(** * Lemmas about comparing [reglist] *)

val lemma_regs_list_match : #t:reg_t -> regs:list (n:nat{n < n_regtype t}) -> r0:regmap -> r1:regmap -> Lemma
	(regs_list_match regs r0 r1 ==>
	 (forall (r:regtyp t). mem r regs ==> r0 t r == r1 t r))
let rec lemma_regs_list_match #t regs r0 r1 = 
match regs with
| [] -> ()
| r::regs' -> lemma_regs_list_match regs' r0 r1

val lemma_reglist_match : t:reg_t -> r0:regmap -> r1:regmap -> Lemma
	(reglist_match t r0 r1 ==>
	 r0 t == r1 t)
let lemma_reglist_match t r0 r1 = 
	lemma_regs_list_match (reglist t) r0 r1;
	lemma_reglist_derive #t (fun r -> r0 t r == r1 t r);
	assert (reglist_match t r0 r1 ==> equal1 (r0 t) (r1 t))

(** * Comparing [regclasses] *)

let rec regs_class_match (regs: list reg_t) (r0:regmap) (r1:regmap) : Type0 =
match regs with
| [] -> True
| t::regs' -> reglist_match t r0 r1 /\ regs_class_match regs' r0 r1

unfold 
let regclasses_match (r0:regmap) (r1:regmap) : Type0 =
	regs_class_match regclasses r0 r1

(** * Lemmas about comparing [regclasses] *)

val lemma_regs_class_match : regs:(list reg_t) -> r0:regmap -> r1:regmap -> Lemma
	(regs_class_match regs r0 r1 ==>
	 (forall t. mem t regs ==> r0 t == r1 t))
let rec lemma_regs_class_match regs r0 r1 =
match regs with
| [] -> ()
| t::regs' -> lemma_reglist_match t r0 r1; lemma_regs_class_match regs' r0 r1

val lemma_regclasses_match : r0:regmap -> r1:regmap -> Lemma
	(regclasses_match r0 r1 ==>
	 r0 == r1)
let rec lemma_regclasses_match r0 r1 =
	lemma_regs_class_match regclasses r0 r1;
	lemma_regclasses_derive (fun t -> r0 t == r1 t);
	assert (regclasses_match r0 r1 ==> equal r0 r1)

(** [va_state_match] *)

let va_state_match (s0:state) (s1:state) : Pure Type0
    (requires True)
    (ensures fun b -> b ==> state_eq s0 s1) =
	let _ = lemma_regclasses_match s0.regs s1.regs in
    s0.ok == s1.ok /\
    regclasses_match s0.regs s1.regs
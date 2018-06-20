module Ins

open State

(** The following definition is basically simulating type
    classes. Consider [ins] to be a type class. Instantiating [ins]
    with some [ins_typ] is providing an instance of [ins]. *)
noeq type ins 'ins_typ = {
  eval_ins : 'ins_typ -> st unit;
  ins_to_string : 'int_typ -> string
}

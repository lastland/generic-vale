module Operand

open State
open FStar.Tactics
open FStar.Tactics.Typeclasses

noeq type operand 'val 'op = {
  valid_operand     : 'op -> state -> bool;
  valid_dst_operand : 'op -> bool;
  check_operand     : 'op -> state -> bool;
  update_operand    : 'op -> 'val -> st unit;
  eval_operand      : 'op -> state -> 'val
}

[@tcnorm] let valid_operand (#v:Type) (#op:Type) [|op : operand v op |] =
  op.valid_operand
[@tcnorm] let valid_dst_operand (#v:Type) (#op:Type) [|op : operand v op |] =
  op.valid_dst_operand
[@tcnorm] let check_operand (#v:Type) (#op:Type) [|op : operand v op |] =
  op.check_operand
[@tcnorm] let update_operand (#v:Type) (#op:Type) [|op : operand v op |] =
  op.update_operand
[@tcnorm] let eval_operand (#v:Type) (#op:Type) [|op : operand v op |] =
  op.eval_operand

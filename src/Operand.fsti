module Operand

open State

noeq type operand 'val 'op = {
  valid_dst_operand : 'op -> bool;
  check_operand     : 'op -> state -> bool;
  update_operand    : 'op -> 'val -> st unit;
  eval_operand      : 'op -> state -> 'val
}

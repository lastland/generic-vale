module Operand64
open Regs
open Operand
open State
open Types

type const64 = { const: nat64 }

let operandConst64 : operand nat64 const64 = {
  valid_operand     = (fun op _  -> 0 <= op.const && op.const < pow2_64 );
  valid_dst_operand = (fun _ -> false);
  check_operand     = (fun _ _  -> true);
  update_operand    = (fun _ _ -> return ());
  eval_operand      = (fun op _ -> op.const)
}

let operandReg64 : operand nat64 (regtyp gReg) = {
  valid_operand     = (fun _ _  -> true);
  valid_dst_operand = (fun op -> op <> rsp);
  check_operand     = (fun _ _   -> true);
  update_operand    = (fun op v  -> s <-- get;
                                 set ({ s with regs = update_regmap gReg op v (s.regs) }));
  eval_operand      = (fun op st -> st.regs gReg op )
}

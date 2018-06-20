module OperandXmm

open Regs
open Operand
open State
open Types

let operandXmm : operand quad32 (regtyp mReg) = {
  valid_operand     = (fun _ _ -> true);
  valid_dst_operand = (fun _ -> true); // I don't know. Is this right?
  check_operand     = (fun _ _ -> true);
  update_operand    = (fun op v -> s <-- get;
                                set ({ s with regs = update_regmap mReg op v (s.regs)}));
  eval_operand      = (fun op st -> st.regs mReg op)
}

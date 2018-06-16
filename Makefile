FSTAR=fstar.exe
FSTAR_OPTS=--include src --record_hints --use_hints --use_hint_hashes --cache_checked_modules --odir _output

.PHONY: all clean
all: src/State.fst.checked src/QuickCode.fst.checked src/Regs.fst.checked src/VaCode.fsti.checked src/Util.fst.checked src/QuickCodes.fst.checked src/Util.fsti.checked src/Types.fst.checked
	$(FSTAR) src/Operand64.fst $(FSTAR_OPTS) --expose_interfaces Regs.fst
	$(FSTAR) src/OperandXmm.fst $(FSTAR_OPTS) --expose_interfaces Regs.fst

clean:
	rm -rf src/*.checked

src/State.fst.checked: src/Regs.fsti.checked
	$(FSTAR) src/State.fst $(FSTAR_OPTS)

src/QuickCode.fst.checked: src/VaCode.fsti.checked src/State.fst.checked
	$(FSTAR) src/QuickCode.fst $(FSTAR_OPTS)

src/Regs.fst.checked: src/Regs.fsti.checked
	$(FSTAR) src/Regs.fst $(FSTAR_OPTS)

src/Regs.fsti.checked: src/Util.fsti.checked
	$(FSTAR) src/Regs.fsti $(FSTAR_OPTS)

src/VaCode.fsti.checked:
	$(FSTAR) src/VaCode.fsti $(FSTAR_OPTS)

src/Util.fst.checked: src/Util.fsti.checked
	$(FSTAR) src/Util.fst $(FSTAR_OPTS)

src/QuickCodes.fst.checked: src/QuickCode.fst.checked src/State.fst.checked src/Regs.fsti.checked
	$(FSTAR) src/QuickCodes.fst $(FSTAR_OPTS)

src/Util.fsti.checked:
	$(FSTAR) src/Util.fsti $(FSTAR_OPTS)

src/Types.fst.checked:
	$(FSTAR) src/Types.fst $(FSTAR_OPTS)

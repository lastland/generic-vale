FSTAR=fstar.exe
FSTAR_OPTS=--include src --log_queries --record_hints

all:
	$(FSTAR) src/QuickCodes.fst $(FSTAR_OPTS)
	$(FSTAR) src/Regs.fst $(FSTAR_OPTS)
	$(FSTAR) src/

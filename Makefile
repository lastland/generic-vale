all:
	fstar.exe src/QuickCodes.fst --include src --log_queries --record_hints
	fstar.exe src/Regs.fst --include src --log_queries --record_hints

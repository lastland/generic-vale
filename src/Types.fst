module Types

open FStar.BitVector

type nat32 = bv_t 32
type nat64 = bv_t 64
type quad32 = (nat32 * nat32 * nat32 * nat32)

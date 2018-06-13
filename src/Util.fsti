module Util

open FStar.List

val range : n:pos -> list (m:nat{m < n})

val lemma_range_complete : n:pos -> m:nat{m < n} -> Lemma
  (mem m (range n))

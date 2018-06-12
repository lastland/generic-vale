module Util

open FStar.List

val range : n:nat -> list (m:nat{m < n})

val lemma_range_complete : n:nat -> Lemma
	(forall m. m < n <==> mem m (range n))
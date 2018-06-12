module Util

let range (n:nat) : list (m:nat{m < n}) =
	let rec range' (n':nat{n'<=n}) : list (m:nat{m < n}) =
		if n' = 0 then [] else (n'-1) :: range' (n'-1) in
	range' n

let rec range_complete : n:nat -> Lemma
	(forall m. m < n <==> mem m (range n)) =
	fun n -> if n = 0 then () else range_complete (n-1)
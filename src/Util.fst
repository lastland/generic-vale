module Util

let rec promote (#n:pos) (l:list (m:nat{m < n})) : list (m:nat{m < (n + 1)}) =
  match l with
  | [] -> []
  | hd::tl -> hd::promote tl

let rec promote_preserves_mem : #n:pos -> m:nat{m < n} -> l:list (m:nat{m < n}) -> Lemma
  (mem m l ==> mem m (promote l)) = fun #n m l ->
  match l with
  | [] -> ()
  | hd::tl -> if m = hd then () else promote_preserves_mem m tl

let rec range (n:pos) : list (m:nat{m < n}) =
  if n = 1 then [0] else (n-1)::promote (range (n-1))

let range_hd (n:pos) : Tot nat =
  match range n with
  | hd::_ -> hd

let rec lemma_range_hd : n:pos -> Lemma
  (range_hd n = n - 1 /\ mem (range_hd n) (range n)) =
  fun n -> if n = 1 then () else lemma_range_hd (n-1)

let lemma_mem_cons : n:pos{n > 1} -> m:nat{m < n} -> Lemma
  (mem m (promote (range (n-1))) ==> mem m (range n)) = fun n m ->
  assert (mem m (promote (range (n-1))) ==> mem m ((n-1)::promote (range (n - 1))))

let lemma_mem_promote : n:pos -> m:nat{m < n} -> Lemma
  (mem m (range n) ==> mem m (promote (range n))) = fun n m ->
  promote_preserves_mem m (range n)

let rec lemma_range_complete n m =
  match n with
  | 1 -> ()
  | _ -> if m = n - 1 then lemma_range_hd n
        else (lemma_range_complete (n-1) m;
              lemma_mem_promote (n-1) m;
              lemma_mem_cons n m)

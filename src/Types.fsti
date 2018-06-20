module Types

unfold let pow2_1 = 0x2
unfold let pow2_2 = 0x4
unfold let pow2_4 = 0x10
unfold let pow2_8 = 0x100
unfold let pow2_16 = 0x10000
unfold let pow2_32 = 0x100000000
unfold let pow2_64 = 0x10000000000000000
unfold let pow2_128 = 0x100000000000000000000000000000000

let natN (n:nat) = x:nat{x < n}
let nat1 = natN pow2_1
let nat2 = natN pow2_2
let nat4 = natN pow2_4
let nat8 = natN pow2_8
let nat16 = natN pow2_16
let nat32 = natN pow2_32
let nat64 = natN pow2_64
let nat128 = natN pow2_128

type two (a:Type) : Type = { lo:a; hi:a; }
type four (a:Type) : Type = { lo0:a; lo1:a; hi2:a; hi3:a; }
type eight (a:Type) : Type = { lo_0:a; lo_1:a; lo_2:a; lo_3:a; hi_4:a; hi_5:a; hi_6:a; hi_7:a }

let quad32 = four nat32

(** elementary 2D graphics *)

type shape = Circle of float | Rectangle of float * float

let area shape =
  match shape with
  | Circle r -> 3.14159 *. r *. r
  | Rectangle (w, h) -> w *. h

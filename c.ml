(* minimal C translator / code generator *)

(** headers/declarations collection: inc/legas.h *)
let h = []

(** generated code (method's implementation etc ): src/legas.c *)
let c = []

(** scalar/primitive types *)
type _ scalar =
  (** 32-bit signed int *)
  | Int : int -> int scalar
  (** 32-bit single precision floating point *)
  | Float : float -> float scalar
  (** C boolean *)
  | Bool : bool -> bool scalar
  (** ASCII char *)
  | Char : char -> char scalar
  (** single byte: uint8_t *)
  | Byte : char -> char scalar

(** composite / compound data types *)
type compos = 
  (** char* *)
  | Str of string

(** any data type *)
type datatype = 
  | Scalar of scalar 
  | Compos of compos
  (** array[] *)
  | Array of datatype list

(** variable *)
type var = { name : string; typ : datatype }

let argc = { name = "argc"; typ = Scalar (Int 2) }
let argv = { 
  name = "argv"; 
  typ = Array [Compos (Str "bin/legas"); Compos (Str "lib/legas.ini")]
}

type fn = { name : string; args : var list; ret : datatype }

let main = { name="main"; args=[];ret=Scalar(Int 0)}

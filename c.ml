(* minimal C translator / code generator *)

(** headers/declarations collection *)
let h = []

(** generated code (method's implementation etc )*)
let c = []

(** scalar/primitive types *)
type scalar = 
(** 32-bit signed int *)
| Int of int 
(** 32-bit single precision floatign point *)
| Float of float
(** C boolean *)
| Bool of bool
(** UCS-2 char:  *)
| Char of char
(** single byte: uint8_t *)
| Byte of char

and
(** data containers = composite / compound data types *)
type compos = Array of scalar | Struct of var list

and 
(** any data type *)
type datatype = Scalar of scalar | Compos of compos

and
(** variable *)
type var = { name : string; typ : datatype }

and 
type fn = { name : string; args : var list; ret : datatype }

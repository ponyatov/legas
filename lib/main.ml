let mkd name = if not (Sys.is_directory name) then Sys.mkdir name 0o700

let inc name =
  mkd "inc";
  let f = open_out (Printf.sprintf "inc/%s.hpp" name) in
  Printf.fprintf f "#pragma once\n";
  close_out f;

let src name =
    mkd "src";
    let f = open_out (Printf.sprintf "src/%s.cpp" name) in
    Printf.fprintf f "#include \"%s.hpp\"\n" name;
    Printf.fprintf f "\nint main() {}\n" ;
    close_out f;


let cpp name = inc name; src name;

cpp "legas"

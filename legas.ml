let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "zmq: cppzmq + pcpp (DPDK)"
let about = ""
let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let version = "0.0.1"
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app

let orig = "https://github.com/seladb/PcapPlusPlus.git"
let tag = "v25.05";;

let user = "dponyatov"
let devserver = "10.120.100.39"
let devuser = "dev01"

#use "legas/files.ml"
files();

#use "legas/ocaml.ml"
ocaml();

#use "legas/doc.ml"
doc();

#use "legas/mk.ml"
mk();

#use "legas/vscode.ml"
vscode()

#use "legas/cpp.ml"
hpp();cpp();init();

#use "legas/cmake.ml"

#use "legas/rust.ml"
main();cargo();

(********************)

#use "legas/git.ml";;
git();;

let refdirs ?(p = Sys.is_directory) d =
  Sys.readdir d |> Array.to_list
  |> List.filter (fun f -> p (Filename.concat d f))
  |> List.filter (fun f ->
      not (List.mem f [ "."; ".."; ".git"; ".github"; ".vscode" ]))
;;

refdirs gitref |> List.iter (fun d -> mkd d ());;

let rfd ?(p = Sys.is_directory) r d =
  Sys.readdir (Filename.concat r d)
  |> Array.to_list
  |> List.filter (fun f -> p (r ^ '/' ^ d ^ '/' f))
  |> List.map (fun f -> Filename.concat d f)
;;

rfd "ref/v25.05" "Pcap++";;

let refiles d =
  refdirs d ~p:Sys.is_regular_file
  |> List.filter (fun f -> not (Sys.file_exists f))
;;

refiles gitref
(* let vibe0 () = *)
(* iterate over ref/${ref} - touch files not exists - mkdir dirs not exists -
   skip dirs: .git *)
;;



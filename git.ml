let git () = 
  Sys.command ("git remote add gh git@github.com:ponyatov/"^app^".git");
  Sys.command ("git remote add flic git@gitflic.ru:dponyatov/"^app^".git");
  Sys.command ("git checkout --orphan `whoami`");
  Sys.command ("git add -A ; git commit -am '.' ; git push -uv gh `whoami` ");

  
(* let gitref = "ref/" ^ tag *)

(* let git () =
  if not (Sys.file_exists (Filename.concat gitref "README.md")) then
    Sys.command
      ("git clone -o orig -b " ^ tag ^ " --depth 1 " ^ orig ^ " " ^ gitref)
    = 0
  else true *)

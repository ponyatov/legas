let extensions () =
  touch ".vscode/extensions.json" ~c:"{
    \"recommendations\": [
        \"stkb.rewrap\",
        \"ms-vscode.makefile-tools\",
        \"IBM.output-colorizer\",
        \"usernamehw.errorlens\",
        // formatters
        \"xaver.clang-format\",
        \"esbenp.prettier-vscode\",
        \"foxundermoon.shell-format\",
        // Linux
        \"ms-vscode-remote.remote-ssh\",
        \"coolbear.systemd-unit-file\",
        // C++
        \"ms-vscode.cpptools\",
        \"jeff-hykin.better-cpp-syntax\",
        \"ms-vscode.cmake-tools\",
        \"krosf.vscode-valgrind\",
        // parser
        \"daohong-emilio.yash\",
        \"rreverser.ragel\",
        // Python
        \"ms-python.python\",
        \"ms-python.autopep8\",
        \"charliermarsh.ruff\",
        // OCaml
        \"ocamllabs.ocaml-platform\",
    ]
}
" ()

let vscode () = 
  mkd ".vscode";
  touch ".vscode/extensions.json" ();
  touch ".vscode/launch.json" ();
  touch ".vscode/settings.json" ();
  touch ".vscode/c_cpp_properties.json" ();
  touch ".vscode/tasks.json" ();
  extensions()

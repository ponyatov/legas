let rust () =
  touch "src/main.rs" ~c:"fn main() {
    println!(\"Hello, world!\");
}
" ()

let cargo () =
  touch "Cargo.toml" ~c:("[package]
name    = \""^app^"\"
version = \""^version^"\"
edition = \"2024\"

[dependencies]
") ()
  Sys.command "cargo run"

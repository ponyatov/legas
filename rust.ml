let rust () =
  touch "src/main.rs" ~c:"mod config;\nmod vm;

use memmap2::Mmap;
use std::fs::File;
use std::io;
use std::io::Write;
use std::path::Path;

fn main() {
    let argv: Vec<String> = std::env::args().collect();
    let _argc = argv.len();
    arg(0, &argv[0]);
    for (argc, argv) in argv.iter().enumerate().skip(1) {
        arg(argc, argv);
        let file = File::open(Path::new(argv)).unwrap();
        let src = unsafe { Mmap::map(&file).unwrap() };
        eprintln!(\"\\tsize: {} bytes\", src.len());
        // eprintln!(\"{:?}\", &mmap[..] as &str);
        io::stdout().write_all(&src[..]).unwrap();
    }
}

fn arg(argc: usize, argv: &str) {
    eprintln!(\"argv[{argc}] = {argv:?}\");
}
" ();
  touch "src/config.rs" ();
  touch "src/vm.rs" ();
  Sys.command "cargo run";

let cargo () =
  touch "Cargo.toml"
    ~c:
      ("[package]
name        =  \"" ^ app ^ "\"
version     =  \"" ^ version ^ "\"
description =  \"" ^ title ^ "\"
authors     = [\""^author^" <"^email^">\"]
license     =  \""^license^"\"
repository  =  \""^github^"\"
edition     =  \"2024\"

[dependencies]

[target.'cfg(target_os = \"linux\")'.dependencies]
libc        = \"0.2\"
memmap2     = \"0.9\"
")
    ();
  Sys.command ("cargo run -- lib/"^app^".ini")

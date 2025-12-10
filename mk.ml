let var () = 
  mkd "mk" ();
  touch "mk/var.mk" ~c:"APP     = $(notdir $(CURDIR))
REL     = $(shell git rev-parse --short=4    HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
NOW     = $(shell date +%y%m%d)
PEPS    = E26,E302,E305,E401,E402,E701,E702
BINFILE = $(APP)_$(HW)_$(BRANCH)_$(NOW)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
WS      = $(shell lsb_release -si)
HW     ?= pc
IP     ?= 127.0.0.1
PORT   ?= 12345
" ()

let dirmk () =
  touch "mk/dir.mk"
    ~c:
      "CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
LIB = $(CWD)/lib
INC = $(CWD)/inc
SRC = $(CWD)/src
TMP = $(CWD)/tmp
REF = $(CWD)/ref
ETC = $(CWD)/etc
"
    ()

let tool () =
  touch "mk/tool.mk"
    ~c:
      "CURL   = curl -L -o
CF     = clang-format -style=file -i
GITREF = git clone -o gh --depth 1
#
PY     = python3
PIP    = pip3
PEP    = autopep8 --ignore $(PEPS) -i
"
    ()

let version () =
   touch "mk/version.mk" ~c:"PCPP_VER = v25.05
" ()

let all () =
  touch "mk/all.mk"
    ~c:
      ".PHONY: all run watch
all: bin/$(APP)
run: bin/$(APP)
\t$^
watch: bin/$(APP)
\t@$^ ; while [ $$? -eq 1 ]; do $^ ; done
#\t@$^ ; while [ true ]; do $^ ; done
"
    ()

let src () =
  touch "mk/src.mk"
    ~c:
      "# .mk files
MK += Makefile $(wildcard mk/*.mk)

# cmake files
CM += CMake* $(wildcard cmake/*.cmake)

# C/C++
C  += $(wildcard src/*.c*)
H  += $(wildcard inc/*.h*)
LX += $(wildcard src/*.lex src/*.yacc src/*.ragel)
# libs
C  += $(wildcard lib/src/*.c*) $(wildcard lib/*/src/*.c*)
H  += $(wildcard lib/inc/*.h*) $(wildcard lib/*/inc/*.h*)

# ini
S  += $(wildcard lib/*.ini) $(wildcard lib/*.f)

# OCaml
M += $(wildcard lib/*.ml*)
"
    ()

let sync () =
  touch "mk/sync.mk"
    ~c:
      ".PHONY: sync
sync: doc
"
    ()

let install () =
  touch "mk/install.mk"
    ~c:
      ".PHONY : install update ref gz
install: $(WS)_install doc ref gz
\t$(MAKE) update
update : $(WS)_update
ref    : $(RF)
gz     : $(GZ)

Debian_install:
Debian_update: apt.$(WS)
\tsudo apt update
\tsudo apt install -uy `cat apt.$(WS)` $(APT)

Ubuntu_install:
Ubuntu_update: apt.$(WS)
\tsudo apt update
\tsudo apt install -uy `cat apt.$(WS)` $(APT)
"
    ()

let mk () =
  mkd "mk" ();
  let m = open_out "Makefile" in
  let makes =
    [
      "var";
      "dir";
      "tool";
      "version";
      "cross";
      "src";
      "all";
      "rule";
      "doc";
      "sync";
      "net";
      "ref";
      "gz";
      "install";
    ]
    |> List.map (fun f -> Filename.concat "mk" (f ^ ".mk"))
  in
  makes |> List.iter (fun m -> touch m ());
  makes |> List.iter (fun r -> Printf.fprintf m "include %s\n" r);
  close_out m;
  var ();
  dirmk() ; tool();
  (* version (); *)
  src();
  all ();
  sync ();
  install ()

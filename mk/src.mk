# .mk files
MK += Makefile $(wildcard mk/*.mk)

# cmake files
CM += CMake* $(wildcard cmake/*.cmake)

# C/C++
C  += $(wildcard src/*.c*)
H  += $(wildcard inc/*.h*)

# ini
S  += $(wildcard lib/*.ini) $(wildcard lib/*.f)

# Python
P += $(wildcard src/*.py) $(wildcard lib/*.py)

# F#
F += $(wildcard lib/*.fs*)

# OCaml
O += $(wildcard bin/*.ml* lib/*.ml* test/*.ml*)

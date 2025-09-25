# g++ -march=native -Q --help=target | grep march
# gcc -march=native -E -v - </dev/null 2>&1 | grep cc1
add_compile_options(
    # -march=ivybridge -mtune=ivybridge
    -march=native -mtune=native
)

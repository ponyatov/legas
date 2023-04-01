grammar FORTH;

COMMENT: '#' [^\n]* ;

NUM: [+\-]?[0-9]+           ;
SYM: [a-zA-Z_][a-zA-Z_0-9]* ;

script: (comment|ex)* ;

ex: NUM | SYM ;

comment: COMMENT ;

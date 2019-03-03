lexer grammar CSVLexer;

HEADER: 'H;' -> pushMode(Mode_Header);
TRAILER: 'T' -> pushMode(Mode_Trailer);
DATA: 'D' -> pushMode(Mode_Data);
META: '#' -> pushMode(Mode_Meta);

X: ';';
NL: '\r'? '\n';

fragment DIGIT: [0-9];
fragment DT_SEP: '/';

mode Mode_Header;
Mode_Header_NL: NL -> type(NL), popMode;
TS: DIGIT DIGIT DIGIT DIGIT DT_SEP DIGIT? DIGIT DT_SEP DIGIT? DIGIT;

mode Mode_Trailer;
Mode_Trailer_X: X -> type(X);
Mode_Trailer_NL: NL -> type(NL), popMode;
NUMBER: DIGIT+;

mode Mode_Data;
Mode_Data_X: X -> type(X);
Mode_Data_NL: NL -> type(NL), popMode;
TEXT: ~[;\n\r]+;

mode Mode_Meta;
Mode_Meta_NL: NL -> type(NL), popMode;
COMMENT: ~[\n\r]+;


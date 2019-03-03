# ANTLR4 Island Grammar

Example of grammar with multiple sub-grammars

## Motivation

We need to parse CSV like file with header; trailer; data and comments entries. Header row is always the first row and header row contains some meta data. Trailer row is always the last row and trailer contains number of all rows and number of data rows.

The rest of the file is mix of data and comments rows:

```
H;2019/1/10
# this is comment
D;Value1;;Value3
# this is comment 2
D;Value1
T;6;2
```

Rows are identified with `H`; `T`; `D` and `#` for header; trailer; data and comment row respectively.

## Grammar without islands

In our example rows have different structure thus some lexical tokens might not be applicable. For example, tokens identifying  row types might be issued by lexer when parsing field values inside "data" rows.

## Islands

In lexer, islands are identified by modes. Token can trigger mode change using `mode`, `pushMode` and `popMode` commands.

```g4
HEADER: 'H;' -> pushMode(Mode_Header);
```

In some situations tokens can be re-used:

```g4
lexer grammar CSVLexer;

// Global tokens
NL: '\r'? '\n';
DELIM: ';';

mode Mode_1;
Mode_1_NL: NL -> type(NL)

mode Mode_2;
Mode_2_NL: NL -> type(NL)
Mode_2_DELIM: DELIM -> type(DELIM)
```

In parser token `NL` can be referred as `NL` (perhaps preferred), `Mode_1_NL` and `Mode_2_NL`. In "mode" tag names or prefixes can be arbitrary:

- `Mode_1_TAG: TAG -> type(TAG);`
- `MY_TAG: TAG -> type(TAG);`
- `OTHER_NAME: TAG -> type(TAG);`

# Final lexer and parser

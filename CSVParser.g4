parser grammar CSVParser;

options { tokenVocab = CSVLexer; }

file: header (data | meta)+ trailer EOF;

header: HEADER timestamp NL;
timestamp: TS;

trailer: TRAILER X d_records X m_records NL;
d_records: NUMBER;
m_records: NUMBER;

data: DATA (X (value | na))+ NL;
value: TEXT;
na: ;

meta: META comment NL;
comment: COMMENT;

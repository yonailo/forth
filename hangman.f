
marker forget-hangman
NEEDS .at NEEDS rnd NEEDS cell

CREATE hgm-w1 ," inspector"
CREATE hgm-w2 ," hospital"
CREATE hgm-w3 ," auxiliary"
3 CONSTANT hgm#
3 CONSTANT max-errors#
0 VARIABLE tries
0 VARIABLE guess-ptr
0 VARIABLE char-found
0 VARIABLE xpos
0 VARIABLE founds

CREATE hgm-words hgm-w1 , hgm-w2 , hgm-w3 ,

: shuffle ( -- )
  hgm# rnd
  CELL * hgm-words + guess-ptr !
;

: guess-len ( -- n ) guess-ptr @ @ count  swap drop ;
: guess-addr ( -- addr ) guess-ptr @ @ count drop ;

: print-hidden ( -- )
  guess-len 0
  do
    0 i 2* .at ." _ "
  loop
;

: print-guess ( c -- )
  guess-len 0 do
    dup guess-addr i + C@ = if
       1 char-found ! guess-addr i + C@
       0 i 2* .at emit ."  "
    then
  loop
  19 xpos @ dup 2+ xpos ! .at emit ."  "
  char-found @ 0 = if
    tries @ 1+ tries !
  else founds @ 1+ founds !
  then
  0 char-found !
  20 0 .at ." t:" tries @ . .",f:" founds @ .
;

: hangman ( -- )
  cls shuffle print-hidden begin
    23 0 .at ." Choose a letter (0 to end) :"
    key
    dup 48 = if \ 48 is ascii code for 0
       quit
    then
    print-guess
    founds @ guess-len = if
      15 0 .at ." CONGRATULATIONS !!" quit
    else
      tries @ max-errors# = if
        15 0 .at ." GAME OVER TRY AGAIN..." quit
      then
    then
  again 
;

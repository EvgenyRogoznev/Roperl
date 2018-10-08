#!/usr/bin/perl

use v5.16;
use utf8;
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-866)') );

while(<DATA>) {
  print if /[щр]/;
}

__DATA__
Строка utf8
Ещё utf8
Дополнительно utf8
Последняя стpока

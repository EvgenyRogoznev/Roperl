#!/usr/bin/env perl -I.
use strict;
use 5.010;
use Isrevalid qw(p_re);
print "$p_re\n";
undef $\;
my$txt=<STDIN>;
$txt=~s/(my func $p_re)/substr($1,0,(length($1)-1).',NULL)'/xegns;
доработать скрипт, роверить не является ли имячастью другого имени,  написать тесты, убедится что это не массив, и т.д.
вид myfunc(  ,   ,  ) заменить ( ,  ,  ,NULL)
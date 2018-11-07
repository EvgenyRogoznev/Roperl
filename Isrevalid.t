#!/usr/bin/perl -I.
use Test::More ;#tests => 2;


if(1==require_ok('Isrevalid')){
do {'Isrevalid'->import;
    };
ok(isrevalid() eq "1", "Function isrevalid() return '1'");
is(isrevalid(''), "1", "empty line");
is(isrevalid('hj'), "1", "good line");
is(isrevalid('[]{}'), "1", "2  line");
is(isrevalid('((()'), "", "not good  line");
is(isrevalid('((()))))'), "", "not good  line");
is(isrevalid('{}[]'), "1", "many  line");
is(isrevalid('((()}}'), "", "not good  line");
is(isrevalid('((({[[[]})))))'), "", "not good  line");

is(isrevalid($_), "", $_) for (')','[',']' )

}
done_testing();
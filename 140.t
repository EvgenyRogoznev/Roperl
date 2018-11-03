#!/usr/bin/perl -I.
use Test::More #tests => 2;


require_ok('140');
use Isrevalid;
ok(isrevalid() eq "1", "Function isrevalid() return '1'");
Sdone_testing();
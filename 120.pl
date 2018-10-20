#!/usr/bin/env perl;
use strict;
use 5.010;
use utf8;
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-866)') );

open (FIL, "<test.txt");

my @string=<FIL>;
foreach my $line (@string){
print $line;
}
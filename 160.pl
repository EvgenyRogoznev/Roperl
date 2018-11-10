#!/usr/bin/env perl -I.
use strict;
use 5.010;
#$_=join'=',@ARGV;
#while(/(-\w+)=([^=]+)/g){
 #   $ARGV{$1}=$2
#};
#our %ARGV=('-key1'=>1,
#-'key2'=>2);
our @pedrms;
'abaabaab'=~/((\w+).?(??{reverse $2;}))(?{push @pedrms,$1;})
(?!)/x;
say "@pedrms";
print "$_\n" for sort{length($a)<=>length ($b)||$a cmp$b}@pedrms;

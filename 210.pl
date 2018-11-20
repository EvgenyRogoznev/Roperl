#!/usr/bin/env perl -I.
use strict;
use 5.010;
say" ctrl Z";


my @aa;
for my$a(<>){
    chomp$a;
    push(@aa,$a);
    };
say"01234567890123456789012345678901234567890123456789";

for (my$i=1,my$h="%".$aa[0]."s";$#aa>=$i;$i++){
   say sprintf ($h,$aa[$i]); 
}

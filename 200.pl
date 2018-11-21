#!/usr/bin/env perl -I.
use strict;
use 5.010;
 my @cat=<>;
#print reverse;
for (my$i=0; ($#cat)>0;$i++){
    my $line=pop(@cat);
    chomp $line;
     my$nom=$i."   ".$line;

    say ($nom);
};
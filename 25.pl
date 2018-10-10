#!/usr/bin/perl -w ;
use v5.16;
use strict;
for (0..5){
    state $a=1;
    my $b=2;
    $a++;
    $b++;
    say " $a+$b= ",$a+$b ;

}
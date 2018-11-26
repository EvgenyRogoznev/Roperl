#!/usr/bin/env perl -I.
use strict;
use 5.010;
my @keys=sort keys %ENV;
my $long=0;
for my $key(@keys){
    if ($long<length $key){
        $long=length $key
    }
$ENV{zzz}="aaaa";
}
for my $key(@keys){
    say sprintf '%*1$.*s  %s',(-$long), $key, $ENV{$key};
    }

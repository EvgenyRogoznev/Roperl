#!/usr/bin/env perl;
use strict;
use 5.010;
my $c=5;
my @b;
my $b=($a,@b,$c)=(1  ,1  ,2  ,2);
say $b ;
$c=reverse @b;
say $c ;
my @a=(1,2,3,4,6);
my @b=grep{$_%2;}@a;
my @c=map{$_,$_*2;}@b;
my @d=sort{$a<=>$b;}@c;

say @b;say @c;say @d;
#!/usr/bin/env perl;
use strict;
use 5.010;
use Test::More;
#my $d=123456789
#(my $a=reverse'1900100')=~s/( \d{3})/$1_/xg;
(my $a='23456778')=~s/(?!^)(?=(?:\d{3})+$)/_/xg;
say $a;

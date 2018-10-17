#!/usr/bin/env perl;
use strict;
use 5.010;
my@a=<>;
my @b=reverse@a;
say $b[10..@b-1];
#!/usr/bin/env perl;
use strict;
use 5.010;
use warnings;
my @lines=<STDIN>;
@lines=reverse @lines;
print "$lines[1]";

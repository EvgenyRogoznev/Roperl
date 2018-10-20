#!/usr/bin/env perl;
use strict;
use 5.010;
use warnings;
chomp(my @lines=<>);
print "@lines";
print $!;

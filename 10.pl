#!/usr/bin/env perl;
use strict;
use 5.010;
my @lines = `perldoc -u -f atan2`;
foreach (@lines) {s/\w<([^>]+)>/\U$1/g;
print;
}
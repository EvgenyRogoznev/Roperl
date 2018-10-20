#!/usr/bin/env perl;
use strict;
use 5.023;
use warnings;
my @names=qw(fred betty barny dino wilma pebbles bam-bam);
my @keys=<STDIN>;
for (@keys){
    print $names[$_-1].","
};
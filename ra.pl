#!/usr/bin/perl
my $FileName='data.txt';
open (DF,"<$FileName") ||die  "Can't open $FileName:$!";
while(<DF>){print;
}

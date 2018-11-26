#!/usr/bin/env perl -I.
use strict;
use 5.010;
my %vocabulary;
for my $key(<>){
    chomp( $key);
    if (exists ($vocabulary{$key})){
            $vocabulary{$key}++;
    }
    else{
        $vocabulary{$key}=1;
    };
};
my@sortkeys=sort keys(%vocabulary);

for my$sortkey(@sortkeys){
    say ($sortkey." ".$vocabulary{$sortkey});
}
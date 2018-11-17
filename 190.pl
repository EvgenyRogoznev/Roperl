#!/usr/bin/env perl -I.
use 5.016;
use MyHash;
tie our %h1, 'MyHash',qw(Name Age Sex);
%h1=(Name=>'mike',Age=>5, Sex=>'mail');

tie our %h2, 'MyHash',qw(key val);
my $h1_r=tied %h1;

untie %h1;
untie %h2;
say "@{[%h1]}";
say "@{[%$h1_r]}";
#!/usr/bin/perl -w ;
use v5.16;
use strict;
say '<!DOCTYPE html>
     <html>
         <head>
        <meta charset ="utf-8"
    </head>
    <body>';
my $r=eval $ARGV[0];
my $t=($@? " <--$@":"=$r");
say $ARGV[0];
say  $t;

say '</body>
        </html>';
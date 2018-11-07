#!/usr/bin/env perl;
use strict;
use 5.010;
sub greet{
    our @named;
    push (@named, $_);
    if (@named.length==1){
        say "Hi $_,you are the first one here!"
    }
    else{ 
        say "Hi $_ ! $[(@named.length)-1] is also here " ;
        }
};
&greet("fred");
&greet("gleb");
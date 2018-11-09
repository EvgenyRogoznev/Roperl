#!/usr/bin/env perl;
use strict;
use 5.010;
sub greet{
    my$arg=$_[0];
    our @named;
    push (@named, $arg);
    if (@named.length==1){
        say "Hi $arg,you are the first one here!"
    }
    else{ 
        say "Hi $arg ! @named[0..(@named.length)-2] is also here " ;
        }
};
&greet("fred");
&greet("gleb");
&greet("fred");
&greet("gleb");
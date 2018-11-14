#!/usr/bin/env perl -I.
use strict;
use 5.010;
BEGIN {
    require MyCl;
};
my$mycl_o=new MyCl();
my$mycl_1_0=$mycl_o->new();
#say \$mycl_o;
#say"$mycl_o";
#say $$mycl_o;
#say $mycl_o->gset(),' ';
#say $mycl_o->gset(10),' ';
#say $mycl_o->gset(4),;
say $mycl_o->gset(),' ';
say $mycl_o->gset(name=>'Mike',age=>5),' ';
say $mycl_o->gset(age=>8);
say $mycl_o->gset(bay=>'red');
$mycl_o->{by}='red';

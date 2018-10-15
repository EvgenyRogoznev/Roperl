#!/usr/bin/perl -w ;
use v5.16;
use strict;
our ($_BASE_FNM, $_MVN, $_XVN); # = ARGV;
sub ch_argv
{
    if (@ARGV!=3){
        say <<EOU;
        Usage: perl gen_fdf.pl fname.FDF MVNum XVNum
EOU
        exit(1);
    };
    ($_BASE_FNM, $_MVN, $_XVN)=@ARGV; $#ARGV=0;
};
sub rw_fdf{
...
}
ch_argv();
rw_FDF();
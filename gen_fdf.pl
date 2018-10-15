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
    my($new_nofa);
    while(<>) {
        if($_=~m/NofA/){  #можно писать в(/NofA/) или если проверить что идет  сначала строки (/^NofA/)
        $new_nofa= (split ' ',$_)[1]-$_MVN-$_XVN
        if ($new_nofa<2){say}
        say 'NofA ',$new_nofa ;
        next;
        }
                print ;
    }
};
ch_argv();
rw_fdf();
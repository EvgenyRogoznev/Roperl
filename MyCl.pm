#!/usr/bin/env perl;
use strict;
use 5.010;
package MyCl;
our $Cl_var=25;
my%dflt=(name=>' ' ,age=>0);
my $lCl_var=3;
sub new {
    my ($cl)=shift;
    $cl=ref($cl)||$cl;
    my $me=0;
    $me+=1;
    bless(\$me,$cl);
    bless {%dflt},$cl;
};
1;
#sub gset{
 #   my($me,$v)=@_;
  #  if(defined($v)&&~/^[0..5]$/ ){
   #     $$me=$v;
#};
#return $$me;
#};
sub gset{
    my($me,%v)=@_;
    if(@_>1){
        %$me=(%$me,%v);
};
return %$me;
};

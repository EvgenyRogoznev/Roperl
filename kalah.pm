#!/usr/bin/env perl -I.
package Kalah;
use strict;
use 5.016;

use base "Game2";
our $STONE_NUM=6;
our $HOLES_NUM=6;
my %dset=(turn=>1,
        kalah1=>0,
        kalah2=>0,
        holes1=>[($STONE_NUM)x$HOLES_NUM],
        holes2=>[($STONE_NUM)x$HOLES_NUM],);
sub new {
    my $cl=shift;
    my $o=(@_?gen_kalah(@_):{%dset});
    $cl=ref($cl)||$cl;
    bless ($o,$cl);
}        
sub is_game_over{return 0;};#0 или 1 или2
sub gen_kallah{{%dset}};
sub get_hn{
    say "vvedite 1-6";
    $_=<STDIN>;
chomp;
$_;}
sub to_txt {
    my ($me,$to)=@_;
    my $txt;
    if ($to==1){
        $txt.=join'','  ', (map{sprintf ' %2d',$_;}reverse @{$me->{holes2}}),"\n";
    
        $txt.=join'', sprintf('%d',$me->{kalah2}),' 'x ($HOLES_NUM x3),$me->{kalah1},"\n";
        $txt.=join'','  ',( map{sprintf (' %2d'),$_} @{$me->{holes1}}),"\n";
        }
   if ($to==2){
        $txt.=join'','  ', (map{sprintf (' %2d'),$_}reverse @{$me->{holes2}}),"\n";
    
        $txt.=join'', sprintf('%d',$me->{kalah2}),' 'x ($HOLES_NUM x3),$me->{kalah1},"\n";
        $txt.=join'','  ',( map{sprintf (' %2d'),$_} @{$me->{holes1}}),"\n";
        };
        $txt;
   }
#    say sprintf '%-3s %-3s %-3s %-3s %-3s %-3s'


1;

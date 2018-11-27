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
        my ($me)=@_;
        my $changedHoles;
        while($changedHoles eq undef){
                say "vvedite 1-6";
        $_=<STDIN>;
         chomp;
        $changedHoles=$_;
        if(${$me->{holes1}}[$changedHoles]==0){
        say"But in this hole not stone, change another hole";
        $changedHoles=undef;
        next;
        };                #проверка не пустая ли лунка
        if (!$changedHoles=~/[1,6]/){say"Not holes with your changed number";
        $changedHoles=undef;
        next;
        };                  #на целое число от 1 до 6
        };
    $changedHoles;
    };
sub to_txt {
    my ($me,$to)=@_;
    my $txt;
    if ($to==1){
        $txt.=join'','  ', (map{sprintf ' %2d',$_;}reverse @{$me->{holes2}}),"\n";
        $txt.=join'', sprintf('%d',$me->{kalah2}),'    'x($HOLES_NUM ),$me->{kalah1},"\n";
        $txt.=join'','  ',( map{sprintf ' %2d',$_} @{$me->{holes1}}),"\n";
        }
   if ($to==2){
        $txt.=join'','  ', (map{sprintf ' %2d',$_;}reverse @{$me->{holes1}}),"\n";
        $txt.=join'', sprintf('%d',$me->{kalah1}),'    'x($HOLES_NUM ),$me->{kalah2},"\n";
        $txt.=join'','  ',( map{sprintf ' %2d',$_} @{$me->{holes2}}),"\n";
        }
       $txt; 
   }
sub do_move {
        our ($me,$hn)=@_;
        our $pl=$me->{turn};
        our $n=$me->{turn};
        our $hole =$me->{'holes'.$n}[$hn];
        sub holePlus {
                $me->{'holes'.$pl}[$hn-1]++;
        }; #кладёт камень в лунку HN PL
        say "holePl";
        sub change_Pl {
                if($pl==1){$pl=2;}
                else{$pl=1;};
               say "chang";
        };
        sub kalahPlus {
                if($pl=$n){
                   $me->{'kalah'.$pl}++;
      #           say  $me->{'kalah'.$pl};
                }
                else{$hole=+1;};
              say 'kalahPlus';
        };# кладёт камень в калах PL ecли PL=Turn  в другом случае hole+1
      for ($pl=$n,$me->{'holes'.$n}[$hn-1]=0;$hole>0;$hole--){

              if (!$hn==6){
                      $hn+=1;
                      holePlus;    
                }
                else{$hn=1;
                kalahPlus;
                change_Pl;
                };
      };    
        };
1;

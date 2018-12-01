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
};        
sub gen_kallah{{%dset}};
sub get_hn{
        my ($me)=@_;
        my $changedHoles;
        while(!defined $changedHoles){
                say "vvedite 1-6";
        $_=<STDIN>;
         chomp;
        $changedHoles=$_;
        if(${$me->{holes1}}[$changedHoles-1]==0){
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
        our $hole =$me->{'holes'.$n}[$hn-1];
        sub holePlus {
                $me->{'holes'.$pl}[$hn-1]++;
        }; #кладёт камень в лунку HN PL
        #say "holePl";
        sub change_Pl {
                if($pl==1){$pl=2;}
                else{$pl=1;};
               #say "chang $pl";
        };
        sub kalahPlus {
                if($pl==$n){
                   $me->{'kalah'.$pl}++;
                }
                else{$hole+=1;};
              #say 'kalahPlus';
        };# кладёт камень в калах PL ecли PL=Turn  в другом случае hole+1
      for ($me->{'holes'.$n}[$hn-1]=0;$hole>0;$hole--){

              if (!($hn==6)){
                      $hn+=1;
                      holePlus;
                }
                else{$hn=0;
                kalahPlus;
                change_Pl;
                };
        }; 
      if($n==$pl && $hole==1){print 2222};
      return 1;   
};
sub turn {
        my ($me,$pl,$hn)=@_;

        if($me->{turn}==$pl){
                if($me->{'holes'.$pl}[$hn-1]==1){
                        #вычислить противоположную лунки игрока и из неё положить всекамни в нашу лунку. в противоположной лунке теперь 0
                }
                else{ &total;
                };
        }else{
                if(#последний камень был в каллах игрока турн )
                {
                        &total;
                }else {$me->{turn}==1?2:1};
                &total
        }

return $me->{turn};
};
sub total {
        my ($me)=@_;
        my @pl1=$me->{holes1};
        my @pl2=$me->{holes2};
        my $sum1;
        my $sum2;
        $sum1 += $_ foreach @pl1;
        $sum2 += $_ foreach @pl2;
        if($sum1==0){$me->{kalah2}+=$sum1;
        $me->{holes2}->[0 x $HOLES_NUM];
        $me->{holes1}->[0 x $HOLES_NUM];
        };
        elsif ($sum2==0){$me->{kalah1}+=$sum2;
        $me->{holes2}->[0 x $HOLES_NUM];
        $me->{holes1}->[0 x $HOLES_NUM];
        };


}
sub get_move {
      my ($me)=@_;
        my $changedHoles;
        while(!defined $changedHoles){
                my $t=$me->{turn};
                return 0 if $me->is_game_over();
                my@ix=grep{$me->{'holes'.$t}->[$_];}1..$HOLES_NUM;
                $changedHoles=$ix[rand 0+@ix];
        
                if(${$me->{'holes'.$t}}[$changedHoles-1]==0){
                        $changedHoles=undef;
                        next;
                        };                #проверка не пустая ли лунка
                if (!$changedHoles=~/[1,6]/){
                        $changedHoles=undef;
                        next;
                };                  #на целое число от 1 до 6
        };
        $changedHoles;
};

sub is_game_over {
        my($me)=@_;
        my($k1, $k2)=($me->{kalah1},$me->{kalah2});
        my $hsq=$STONE_NUM*$HOLES_NUM;
        return 0 if ($k1<$hsq&& $k2<$hsq);
        $me->{turn}=0;
        return $Game2::WIN1 if $k1>$hsq;
        return $Game2::WIN2 if $k2>$hsq;
        return $Game2::WIN3 if $k1==$hsq/2;
        };    

1;

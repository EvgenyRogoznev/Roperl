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

sub new  {
    my $cl=shift;
    my $o=(@_?gen_kalah(@_):{%dset});
    $cl=ref($cl)||$cl;
    bless ($o,$cl);
};     
sub gen_kallah {{%dset}};
sub get_hn{
        my ($me)=@_;
        my $changedHoles;
        while(!defined $changedHoles ){
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
        my ($me,$hn)=@_;
        my $t=$me->{turn};
        return $Game2::INV_TURN if $me->is_game_over()||$hn<1||$me->{$t==1?'holes1':'holes2'}->[$hn-1]<=0;
        my $n=$me->{turn};
        my $hix=$hn-1;
        my $hole =$me->{'holes'.$n}[$hn-1];
        my $q=$me->{'holes'.$n}[$hix];
 my $chs_r=$me->{'holes'.$t};
        $q=$chs_r->[$hix];
        $chs_r->[$hix]=0;
$hix++;
while($q){
        if($hix>=$HOLES_NUM){
                if($t==$me->{turn}){
                        $me->{'kalah'.$t}++;
                        $q--;
                        if(!$q){$me->is_game_over();
                        return 1;
                        };
                };
                $t=($t==1?2:1);
                $chs_r=$me->{'holes'.$t};
                $hix=0;
        };
        $chs_r->[$hix]++;

        }continue {$q--;$hix++};
        if ($t==$me->{turn}){
                if($chs_r->[$hix-1]==1){
                        $me->{'kalah'.$t}+=1+$me->{$t==1?'holes2':'holes1'}->[$HOLES_NUM-$hix];
                        $me->{'holes'.$t}->[$hix-1]=$me->{$t==1?'holes2':'holes1'}->[$HOLES_NUM-$hix]=0;
                }
        }
return 1 if check_empty($me);
        $me->{turn}=($me->{turn}==1?2:1);
return 1;
}

sub check_empty {
        my ($me)=@_;
        if(grep{$_>0}@{$me->{holes1}}){
                $me->{kalah2}+=$me->{holes2}->[$_],$me->{holes2}->[$_]=0 for 0..($HOLES_NUM-1);
        }elsif(grep{$_>0}@{$me->{holes2}}){
                $me->{kalah1}+=$me->{holes1}->[$_], $me->{holes1}->$_=0 for 0..($HOLES_NUM-1);
        };
        $me->is_game_over();
};
sub turn {
            my ($me)=@_;
return $me->{turn};    
};
sub get_move{
            my ($me)=@_;
my $t=$me->{turn};
return 0 if $me->is_game_over();
my@ix=grep{$me->{'holes'.$t}->[$_];}1..$HOLES_NUM;
return $ix[rand 0+@ix];
};

   #      sub holePlus {
   #             $me->{'holes'.$pl}->[$hn-1]++;
    #     }; #кладёт камень в лунку HN PL
     #    say "holePl";
       #  sub change_Pl {
 #                if($pl==1){$pl=2;}
   #              else{$pl=1;};
     #           say "chang";
       #  };
  #       sub kalahPlus {
    #             if($pl=$n){
      #              $me->{'kalah'.$pl}++;
      #           say  $me->{'kalah'.$pl};
   #              }
     #            else{$hole=+1;};
       #        say 'kalahPlus';
    #     };# кладёт камень в калах PL ecли PL=Turn  в другом случае hole+1
   #    for ($pl=$n,$me->{'holes'.$n}[$hn-1]=0;$hole>0;$hole--){
 #
   #            if (!$hn==6){
     #                  $hn+=1;
       #                holePlus;    
         #        }
           #      else{$hn=1;
   #               kalahPlus;
      #           change_Pl;
        #         };
     #  };    
       #  };
        sub is_game_over {
                my($me)=@_;
                my($k1, $k2)=($me->{kalah1},$me->{kalah2});
                my $hsq=$STONE_NUM*$HOLES_NUM;
                return 0 if $k1<$hsq&& $k2<$hsq;
                $me->{turn}=0;
                return $Game2::WIN1 if $k1<$hsq&& $k2<$hsq;
                return $Game2::WIN2 if $k1<$hsq&& $k2<$hsq;
                return $Game2::WIN3 if $k1<$hsq&& $k2<$hsq;
        };    
1;
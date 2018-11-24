#!/usr/bin/env perl -w -I.
use 5.016;
use Kalah;
my $is_game_o = new Kalah();
my ($hn,$cc);
while (!$is_game_o->is_game_over()){
    print $is_game_o->to_txt(1);
    $hn=get_hn($is_game_o);
    $cc=($is_game_o->do_move($hn));
    if (0==$cc){say "$cc";# дуальная прерменная в строке одно в числе другое
    next;
    }
    print $is_game_o->to_txt(1);
    while (2==$is_game_o->tyrn()){
        print $is_game_o->to_txt(1);
        $hn=$is_game_o->get_move();
        }
}
if (1==$is_game_o->is_game_over()){
    say "you win";
};
if (2==$is_game_o->is_game_over()){
    say "you lose";
};
if (3==$is_game_o->is_game_over()){
    say "win frendchip";
};
1;
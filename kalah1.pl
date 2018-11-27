#!/usr/bin/env perl -w -I.
use 5.016;
use Kalah;
my $is_game_o = new Kalah();
my ($hn,$cc);
while (!$is_game_o->is_game_over()){#если не геймовер  цикл
    print $is_game_o->to_txt(1);    #вывести состояние  
    $hn=($is_game_o->get_hn);       #получить число 
    #print $hn;
    $cc=($is_game_o->do_move($hn)); # сделать ход на полученую цифру, вернуть значение СС число "0"
                                    # если повтор хода и причину повтора в строке
    if (0==$cc){say "$cc";# дуальная прерменная в строке одно в числе другое
    next;
    }
    print $is_game_o->to_txt(1);
    while (2==$is_game_o->turn()){
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
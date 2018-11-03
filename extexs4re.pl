#!/usr/bin/perl

use v5.16;
use utf8;
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-866)') );

use Demonstrator;
use re 'eval';


our @exs =
(   #{=======================================================



sub {
    N 0                                        ;
#   -----------    (?=)     (?<=)     (?{})
    my ($re, $t, $r);
    $t = '"Серо-буро-малиновый в крапинку" - это очень сложно окрашенный.' ."\n".
         'А "бесцветный" --- это прозрачный?';

#.0
    $re = qr/                       (?{ print pos(), ':'; })
                (?<=\s) - (?=\s)    (?{   say "$&;";      })
            /ux;
    ($r=$t) =~ s/$re/---/ugs;             say "\n  Result:\n$r\n";
    
#.1
    $re = qr/                       (?{ print pos(), ':'; })
                (\s) - (\s)         (?{   say "$&;";      })
            /ux;
    ($r=$t) =~ s/$re/$1---$2/ugs;         say "\n  Result:\n$r\n";

},




sub {
    N 1                                        ;
#   -----------    (?=)     (?{})
    our (%wq);
    my ($re, $t);
    $t = 'У газели Waller длинная шея, но жираф длинношеее.';

#.0
    $re = qr/
                ((.)\2+)  (?{$wq{$1}++ if 2==length($1);})
            /x;
    () = $t =~ /$re/ug;
    while (my ($s,$q) = each %wq) {  say "'$s' => $q";  }

#.1
                                     say'';
    %wq=();
    $re = qr/
                (?<=(.)) (?!\1) ((.)\3) (?!\3)  (?{$wq{$2}++})
            (?!)
            /x;
    $t =~ /$re/u;
    while (my ($s,$q) = each %wq) {  say "'$s' => $q";  }

},





sub {
    N 2                                        ;
#   -----------    Проблема парных скобок (?>)     (?1)    (?|)
    my ($re, $pt, $res);

    $re = qr{
                ( # группа 1 (скобки вместе с содержимым)
                    \(
                    ( # группа 2 (содержимое скобок)
                        (?:
                            (?> [^()]+ ) # "нескобки" очень жадно
                            |
                            (?1)         # рекурсивное обращение к группе шаблонов 1, если скобка
                        )*
                    )
                    \)
                )
            }x;
        
    ($res = $pt = 'sin(PI/(k+1)))' ) =~ s/$re//g;
    say "Очень много '$1' in $pt" if $res=~/(?| (\(\)) | ([()]) )/x;

    ($res = $pt = 'sin(PI/(k+(h/h0)))+cos(PI/(k+()))' ) =~ s/$re//g; # пример пропуска семантической ошибки
    say "Очень много '$1' in $pt" if $res=~/(?| (\(\)) | ([()]) )/x; # или другой диагностики
    
    ($res = $pt = 'sin(PI/(k*2)+cos(PI/(k*2)))' ) =~ s/$re//g;  # пример пропуска ошибок из-за их чётного числа
    say "Очень много '$1' in $pt" if $res=~/(?| (\(\)) | ([()]) )/x;

},




sub {
    N 3                                        ;
#   -----------  ExtRegExpr:  (*FAIL)  (*COMMIT)    (?{})

          #012345
    my $r='aaabb'=~/
                    (*COMMIT)       (?{ print "\n  A($&):"     })
                    (                   (?{ print ' ',pos(),':' })
                        a                   (?{ print $&         })
                    )+              (?{ print "\n AB($&):"     })
                    (                   (?{ print ' ',pos(),':' })
                        ab                  (?{ print $&         })
                    )+              (?{ say   "\n  F:"         })
                    (*FAIL)
        /x;
        
    say "\nRE=$main::REGERROR Rslt=$r";

},




sub {
    N 4                                        ;
#   -----------  ExtRegExpr:  (*MARK)
    use Benchmark qw(cmpthese :hireswallclock);
    no strict 'refs';

    our ($l, $sdp,$smp,$scp,$sgp, $x,$y,$z, $m);
    *m = \$main::REGMARK;
    my ($count);
    $count = $ENV{COUNT} // 500000;

    BEGIN {
        (   $sdp,   $smp,   $scp,   $sgp
        ) =
        (   qr/(?:(x)|(y)|(z))=(\d+)/,
                    qr/(?:x(*:X)|y(*:Y)|z(*:Z))=(\d+)/,
                            qr/(x|y|z)=(\d+)(?{${$1}=$2;})/,
                                    qr/(x|y|z)=(\d+)/,
        );
    };
    
    sub sd {  $l=~/$sdp/o;  (defined($1)? $x:  defined($2)?$y: $z) = $4; };
    sub sd1{  $l=~/$sdp/o;  (  $1 eq 'x'? $x:  $y eq 'y'?  $y: $z) = $4; };
    sub sm {  $l=~/$smp/o;  (  $m eq 'X'? $x:  $m eq 'Y'?  $y: $z) = $1; };
    sub sc {  $l=~/$scp/o;                                               };
    sub sg {  $l=~/$sgp/o;  ${$1}=$2;                                    };
    
    my ($it, $t);

    $l = 'r,z has to be integer. Let r=0, z=2.';
    ($x,$y,$z)=(0,0,0);  sd();  say "$x,$y,$z";
    ($x,$y,$z)=(0,0,0);  sd1(); say "$x,$y,$z";
    ($x,$y,$z)=(0,0,0);  sm();  say "$x,$y,$z";
    ($x,$y,$z)=(0,0,0);  sc();  say "$x,$y,$z";
    ($x,$y,$z)=(0,0,0);  sg();  say "$x,$y,$z";
    
    say '   Wait a minute';
    cmpthese( $count,  {    'def1' => \&sd,
                            ' eq1' => \&sd1,
                            ' eqm' => \&sm,
                            'code' => \&sc,
                            'glob' => \&sg,
                       }
            );
    
},



sub {
    N 5                                        ;
#   -----------  ExtRegExpr:  (*:NAME)  (*PRUNE:NAME)   $main::REGERROR  RM:$main::REGMARK

    say "\n\nR=".
         #01234567
        ('xxxyxyz'=~/                       (?{ print "\n\n  X($&)"                })
                        (   (*:BR_X)            (?{ print " $main::REGMARK.",pos()  })
                            x                       (?{ print ':',$&                 })
                        )*                  (?{ print "\n XY($&)"                  })
                        (  (*:BR_Y)             (?{ print " $main::REGMARK.",pos()  })
                            xy                      (?{  print ':',$&                })
                            (*PRUNE:PRUNE)
                        )                   (?{ print "\n  Z($&)"                  })
                        (   (*:BR_Z)            (?{  print " $main::REGMARK.",pos() })
                            z                       (?{  print ':',$&                })
                        )+
                                            (?{ print "\n F($&) $main::REGMARK.",pos() })
                    (*F)
                    /x
        );
    say "RE:$main::REGERROR  RM:$main::REGMARK";

},




sub {
    N 6                                       ;
#   -----------  ExtRegExpr:  (*SKIP)       (*MARK:A) (*SKIP:A)    (*PRUNE)
    our ($count);
    my ($s) = ('aabbaaaabb');

    $count=0;
    $s =~ /aa*b+(*SKIP)(?{print "$&\n"; $count++})(*FAIL)/;
    say "     Count: $count RE:$main::REGERROR";

    $count=0;
    $s =~ /aa(*MARK:A)a*b+(*SKIP:A)(?{print "$&\n"; $count++})(*FAIL)/;
    say "     Count: $count RE:$main::REGERROR";


    $count=0;
    $s =~ /aa(*MARK:A)a*b+(*SKIP:B)(?{print "$&\n"; $count++})(*FAIL)/;
    say "     Count: $count RE:$main::REGERROR";
    
    $count=0;
    $s =~ /a+b+(*PRUNE)(?{print "$&\n"; $count++})(*FAIL)/;
    say "     Count: $count RE:$main::REGERROR";

},





);  #}=======================================================


my $d = new Demonstrator( $0, \@exs );
$d->work();

__END__

=head1 NAME

 ops.pl    - Demonstrator of Perl operations and operators.

There are an array of text examples in 'for'.

=head1 SYNOPSYS

 perl ops.pl        - to demonstrate all examples
 perl ops.pl N      - to demonstrate the N-th example
 perl ops.pl N1 N2  - to demonstrate the examples from N1 to N2

=cut

package Isrevalid;
use 5.016;
require Exporter;
our $VERSION=v0.1;
our @ISA = qw(Exporter);
our @EXPORT = "&isrevalid";
our @EXPORT_OK=qw($p_re %orc );
our %orc=('('=>'\)','{'=>'\}','['=>'\]');
our $p_re=qr/(?'pp'
        (?'op'[[{(])(?{say"1:$`:$&:";})
        (?:
       (?>[^][)(}{]+)(?{say"2:$`:$&:";})
        |
        (??{$+{'pp'};})(?{say"3:$`:$&:";})
        )*
        (??{$orc{$+{'op'}};})
    )/x;
sub isrevalid {
    my($e)=@_;
    my $t=$e;$t=~s/[^][(){}]//g;
    $t=~/^$p_re$|^$/xo;
};
1;
package Isrevalid;
use 5.016;
our $VERSION=v0.1;
our @ISA = "Exporter";
our @EXPORT = "&isrevalid";
our @EXPORT_OK=qw(p_re);
our %orc=('('=>'\)','{'=>'\}','['=>'\]');
our $p_re=qr/^(
        ([[{(])
        (?:
        S
       (?>[^][)(}{]+)
        |
        (?1)
        )*
        (??{$orc{$2};})
    )/x;
sub isrevalid {
    my($e)=@_;
    my $t=$e;$t=~s/[^][(){}]//g;
    $t=~/^$p_re$|^$/xo;
};
1;
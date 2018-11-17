package MyHash;
use 5.016;
#require Exporter;
#our @ISA = qw(Exporter);
#our @EXPORT = "&";   допилить
#our @EXPORT_OK=qw($p_re %orc );
use Carp;
BEGIN {require Tie::Hash;
our @ISA ='Tie::StdHash';}
my %keys;
sub TIEHASH {
    my($cl)=shift;
    my$me=bless({},$cl);
    $keys{$me}={map{;$_,undef}@_};
    # my %tmph=(map{;$_,undef}@_); строка 14 обозначает то же что строки 15и16
    # $keys{$me}=\%tmph;
    $me;

};
sub STORE {
    my($me,$k,$v)=@_;
    if(!exists $keys{$me}->{$k}){
    croak "can not use $k as hash keys";
    };
$me->SUPER::STORE;#УСТАРЕВШИЙ ВЫЗО ФУНКЦИИ НЕ МЕНЯЮЩИЙ МАССИВ @_

};
sub DESTROY{delete $keys{$_[0]}};
1;
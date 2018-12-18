package Firstpack;
use strict;
use 5.021;
use warnings;

sub new {
    my $class=shift;
    my $param={};
    $param->{name}="first";
    $param->{x}=1;
    $param->{y}=2;
    bless($param,$class);
};
sub hi{
    say "hello";
};
sub sum {
    use Data::Dumper;
warn Dumper \@_;

    my ($self)=@_;
    my $x=$self->{x};
    my $y=$self->{y};
    my $z=$x+$y;
    #my $y=$param->{x}+$param->{x};
    say $z;
};
1; 
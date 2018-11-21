package GenKey;

require Exporter;

our @EXPORT = qw(&ABC &gen_key);
our @ISA = qw(Exporter);

my @l = ('A'..'Z', 'a'..'z', 0..9);

sub ABC{@l};

sub gen_key
{   my ($l) = @_;

    my $r='';
    for (1..$l){
        $r .= $l[ rand( 0+@l ) ];
    }
    return $r;
}
 
1;


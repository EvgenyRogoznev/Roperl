package Demonstrator;

use v5.16;
use utf8;
use B::Deparse;
use Getopt::Long;

use fields qw(fnm source from to exs_r deparser);

our @ISA    = qw(Exporter);
our @EXPORT = qw($N &N);

our $N;
sub N($){$N=shift};


sub usage
{
    my $self = shift;
    my $me = $self->{fnm};
    $me =~ s{.*[\\/]}{};
    my $lstn = $#{$self->{exs_r}};

    say <<EOU ;

 Usage: perl $me N1     - to do example N1
        perl $me N1 N2  - to do examples from N1 to N2
        perl $me        - to do all examples from 0 to $lstn
        perl $me -h     - to see this text
EOU
    exit 1;
}




sub new
{
    my $self = shift;
    unless (ref $self) {
        $self = fields::new($self);
    }
    $self->init(@_);
    return $self;
}


sub read_source
{   my $self = shift;
    local @ARGV=($self->{fnm}); # локально изменяем массив аргументов, чтобы воспользоватьься мощью <>
    $self->{source} = [ map {$a=$_; utf8::decode($a); $a} <> ];
    return 1;
}



sub init
{   my ($self, $fnm, $exs_r) = (shift, shift, shift);
    $self->{fnm}      = $fnm;
    $self->{exs_r}    = $exs_r;

    my $help = 0;
    GetOptions( help => \$help );
    $self->usage() if $help;
    
    my ($from, $to) = @ARGV;
    ($from,$to)     = (0,$#$exs_r)  if !defined $from || $from<0;
    $to //= $from;
    ($to, $from)    =  ($from,$to)  if $from>$to;
    @$self{'from','to'} = ($from,$to);
    
    $self->{deparser} = B::Deparse->new('-l');
    
    $self->read_source();
}


sub pr_sub
{   my  ($self, $ex_r) = (shift, shift);
    my   $txt = $self->{deparser}->coderef2text($ex_r);  # get text sub by sub's reference
    my  ($ln);
    $ln = $1  if $txt =~ /^#line\s+(\d+)/ms;  # get the first line number of the example
    for (   @{$self->{source}}[ ($ln-1)..$#{$self->{source}} ]  ) {
        last if /^\}/; # we believe that the last '}' in each example is in the initial position of the line
		print;
    };
}


sub work
{   my  $self = shift;
    my  $sub_r;

    for($self->{from}..$self->{to}) {
		say "\n\n\n\n\n";
        $sub_r = $self->{exs_r}->[$_];
        $self->pr_sub( $sub_r );
        <STDIN>;
        &$sub_r;
        <STDIN> if $_ != $self->{to};
    }
}


1;

__END__
#!/usr/bin/perl

use v5.16;
use Encode;

our ( $F1LEN ) = ( 30 );
our $SPACE = ' ' x $F1LEN;


sub pr_pair
{ my ($l) = @_;
  ($l=decode('UTF-8',$l)) =~ s/\s*#.*//ms;
  chomp $l;
  return unless $l;

  my ($actor, $obj) = split /\s*=>\s*/, $l;
  $actor = substr( $SPACE, 0, $F1LEN-length($actor) ) . $actor  if length($actor)<$F1LEN;
  print encode( 'UTF-8', "$actor\n$SPACE$obj" ), "\n";
}

pr_pair $_ while<>;

__END__


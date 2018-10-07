#!/usr/bin/perl
use v5.16;

use Reduce qw(reduce sum);
our $DBG = 0; # my $DBG = 1;

($a,$b) = (-1,-1);
my @list = (1,2,3,4,6);

print( 'sum by reduce(): ', (reduce {$DBG && print("  a:$a b:$b\n");$a+$b} @list),
                                              " a=$a\n"
	 );
print 'sum by sum(): ',      sum(@list),      " a=$a\n";
print 'sum by sum0(): ', Reduce::sum0(@list), " a=$a\n";


__END__

use Benchmark;

timethese(100000, {
            sum    => sub { sum(@list) },
            sum0   => sub { Reduce::sum0(@list) },
            sum_1  => sub { Reduce::sum_1(@list) },
            sum0_1 => sub { Reduce::sum0_1(@list) },
      });

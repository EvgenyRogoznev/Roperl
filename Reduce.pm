# Reduce.pm
#
# Copyright (c) 2016-2017 ...
#

package Reduce;

use strict;
use warnings;

BEGIN {
    # Inherit from Exporter to export Exporter::import() function
  require Exporter; 
  our @ISA        = qw(Exporter);
    # Set the version for version checking
  our $VERSION    = 1.00;
    # Functions and variables which are exported by default
  our @EXPORT     = qw(reduce);
    # Functions and variables which can be optionally exported
  our @EXPORT_OK  = qw(sum);
}


# This procedure is incapsulated in module
my $reduce = sub
{   my ($bl_p);
    ($bl_p, $a, $b) = @_;
    return &$bl_p; 
};


sub reduce(&@)
{   my ($bl_p, @list) = @_;
    return undef unless @list; # @list is empty
    return $_[1] if 1==@list;  # there is one element in @list
    my $package = caller();
    if ($package ne __PACKAGE__) {
        no strict 'refs';
        *a=*{"${package}::a"};
        *b=*{"${package}::b"};
    }
    local ($a, $b);
                              # Another way to do it:
    my $prev_val = $list[0];  # ... = shift @list;
    for(@list[1..$#list]) {   # for(@list) {
        $prev_val = $reduce->($bl_p,$prev_val,$_);
    }
    return $prev_val;
}


sub sum
{  return reduce {$a + $b} @_;
}


# This procedure can be called from another module with the package name
sub sum0
{  return reduce {$a + $b} 0,@_;
}

sub sum_1
{ unshift @_, sub {$a + $b};
  return &reduce;
}

sub sum0_1
{  unshift @_, sub {$a + $b}, 0;
   return &reduce;
}


1;

__END__

=head1 NAME

Reduce - General reduce function and a selection of subroutines based on it

=head1 SYNOPSIS

    use Reduce;
    use Reduce qw(sum);

=head1 DESCRIPTION

By default C<Reduce> exports reduce() function only.

=over 4

=item reduce BLOCK LIST

Reduces LIST by calling BLOCK, in a scalar context, multiple times,
setting C<$a> and C<$b> each time. The first call will be with C<$a>
and C<$b> set to the first two elements of the list, subsequent
calls will be done by setting C<$a> to the result of the previous
call and C<$b> to the next element in the list.

Returns the result of the last call to BLOCK. If LIST is empty then
C<undef> is returned. If LIST only contains one element then that
element is returned and BLOCK is not executed.

=item sum LIST

Returns the sum of all the elements in LIST. If LIST is empty then
C<undef> is returned.

    $foo = sum 1..4,6               # 16

    @foo = (1..4,6);                # 1,2,3,4,6
    $foo = sum @foo, @foo           # 32

This function could be implemented using C<reduce> like this

    $foo = reduce { $a + $b } 1..4,6

Pass C<0> as the first argument to prevent C<undef> being returned

  $foo = sum 0, @foo

=back

=head1 KNOWN BUGS

=head1 SEE ALSO

L<List::Util>, L<List::MoreUtils>, L<Scalar::Util>

=head1 COPYRIGHT

Copyright (c) 2016-2017 ...

=cut

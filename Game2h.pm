#!/usr/bin/env perl;
package Game2;
use base 'Exporter';
use strict;
use 5.016;
our $WIN1=1; 
our $WIN2=2;
our $WIN3=3;
our $EXPORT_OK= qw($WIN1 $WIN2 $WIN3);
our $INV_TURN=0;


sub is_game_over {...};
sub new {...};
sub totxt {...};
sub get_hn {...};
sub do_move {...};
sub get_move {...};
sub turn {...};
1;
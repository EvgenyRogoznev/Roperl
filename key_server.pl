#!/usr/bin/perl -w

use strict;
use threads;
use Socket;

use GenKey;

my $PORT    = $ARGV[0] || 2013;
my $KEY_LEN = $ARGV[1] || 100;

$SIG{'PIPE'} = 'IGNORE';

my $answer = gen_key( $KEY_LEN );

socket(my $s, PF_INET, SOCK_STREAM, getprotobyname('tcp')) or die "Socket: $!";
setsockopt($s, SOL_SOCKET, SO_REUSEADDR, pack('l', 1)) or die "Setsockopt: $!";

my ($port, $host) = ($PORT, '0.0.0.0');

bind($s, sockaddr_in($port, inet_aton($host))) or die "Bind: $!";
listen($s, SOMAXCONN) or die "Listen: $!";

while (accept(my $c, $s)) {
	threads->create(\&p, $c)->detach;
}

sub p {
	my ($c) = shift;
	select $c;
	++$|;
	while(my $l = <$c>) {
		$l =~ s/\r?\n$//;
        print $KEY_LEN - ($answer =~ /^$l/? length($l) : 0 ), "\n";
	}
	close $c;
}


#!/usr/bin/perl
use strict;
use IO::Socket::IP;
use GenKey;


my $PORT = $ARGV[0] || 2013;
 
my $s = IO::Socket::IP->new(
            PeerHost => "127.0.0.1",
            PeerPort => "$PORT",
            Type     => SOCK_STREAM,
            Family   => AF_INET
) or die"Cannot construct socket - $@";
 
my $key = '';
my $klen;
my @l = ABC();

W:  while (1) {
        for my $l ($key?@l:('',@l)) {
            my $test = $key . $l; 
            $s->say($test);
            my $answer;
            eval {
                local $SIG{ALRM} = sub { die "Timeout from server!\n" };
                alarm 5;
                $answer = $s->getline();
                alarm 0;
            }; 
            die $@ if $@;
            if ($l eq '') {
                $klen = 0+$answer;
                next;
            } elsif ($answer < $klen) {
                if ($answer>0) {
                    $key = $test;  print STDERR "$key\n";
                    next W;
                };
                print "ANSWER: $test\n";
                last W;
            };
        }
    }

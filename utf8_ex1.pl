#!/usr/bin/perl

use v5.16;
use utf8;
<<<<<<< HEAD
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-1251)') );
=======
say"прпрполв";
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-866)') );
>>>>>>> 550eb9821167a338381deca984c016d8cad84fd3

sub pause_pr
{
  local $|=1;
  my $symbs = join $;, @_;
  for (split '',$symbs) {
      print if $_ ne $; ;
	  select(undef,undef,undef,0.15) if !/!/;
  }
}


sub мама()
{ 
  pause_pr( "MAAAMAA!!!\n", '', '',
            'ОТОЙДИ ОТ МОЕГО РЕБЁНКА!!! ', ('','','','.')x3,
		    ' Ну,', '','', ' лапушка,', '', ' всё уже хорошо,', '', '', ' сейчас он только лежать может,',
			('')x6, ' без головы-то.', "\n"
	      );
}

мама;

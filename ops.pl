#!/usr/bin/perl
use v5.16;
use utf8;
binmode(STDOUT, ':encoding'.($ENV{'LANG'}? '(utf8)': '(cp-866)') );

use Demonstrator;

$|=1;

our @exs =
(   #{=======================================================



sub {
       N 0                                      ;
  # ----------- =    ''   unary-    "$"    say

#   N0.1                            N0.2
#
    $a = 'aa';                      $b = '10';
    $a = -$a;                       $b = -$b;
             say(  "a=$a  b=$b"  );

    $a = -$a;                       $b = -$b;
             say   "a=$a  b=$b";

},



sub {
       N 1                                      ;
  # ----------- = =     +=      our my      say()

    $main::C =
    $main::D = 5;           say "CpDp:  $main::C $main::D\n";


#.1 ----
     our  $C = $C+20;                                       #<~~~> (??? my *C=\$main::C ???);  $C=$C+20;
    {
     our  $C;       $C++;   say "CpCl:  $main::C $C";
    };
                            say "CpCl:  $main::C $C\n";

#.2 ----
     my  $D = 1;                                            # my $F=(...);  <~~~>  $???=(...);  my $F;  $F=$???;
    {               $D+=2;  say "DpDl:  $main::D $D";
     our $D;        $D+=4;  say "DpDl:  $main::D $D";
     my  $D = $D;   $D+=8;  say "DpDl:  $main::D $D";
    };
                            say "DpDl:  $main::D $D";

},





sub {
       N 2                                                                               ;
  # ----------- "\$c" \$c   sub @_    , =>    ref    \ ${'a'}    q// qq//   my our local
        our     $c;
        our     ($c_r, $c_nm);
                
    sub pr{       no strict 'refs';         # Within a subroutine the array @_ contains the parameters
                                            # passed to that subroutine (perlvar).
                  say  qq /@_:/
                       ,q/  ${c}:/      =>  ${c}   # "fat comma":  ID=>10 <~~~> "ID",10    1=>2 <~~~> 1,2 (perlop)
                       ,q/  ${'c'}:/    =>  ${'c'}
                       ,q/  ${$c_nm}:/  =>  ${$c_nm}
                       ,q/  $$c_r:/     =>  ${$c_r}
                       ,q/  $c_r:/      =>  (  join  '.',   $c_r,  ref($c_r),  0+$c_r  )    # see perlfunc
                  ;
    };


               $c = 'global';
               ($c_r, $c_nm) = (\$c, 'c');   pr(1);
        {    
        local  $c = 'local ';                       # change the VALUE of global name down to the end of the code block
               ($c_r, $c_nm) = (\$c, 'c');   pr(2);

        my     $c = 'my    ';                       # redefine the NAME down to the end of the code block
               ($c_r, $c_nm) = (\$c, 'c');   pr(3);
        };
               ($c_r,$c_nm)  = (\$c, 'c');   pr(4);

},




sub {
       N 3                                                            ;
  # -----------  sub  @_    = ,    , +    "$" "@"   $, say           # my   our   local

  sub v{ say "   @_";   return $_[0] }              # Within a subroutine the array @_ contains the parameters
                                                    # passed to that subroutine (perlvar).
  
                                my $oldcomma = $,;      $, = ":\t";     # local $, = ":\t";

  our @a = ( v(1),v(2),v(3) );  say "a=(,,)","@a";  ## our @a; {my @b; $b[0]=v(1); $b[1]=v(2); $b[2]=v(3); *a=\@b;};

  $a = v(1),v(2),v(3);          say "S=,,",   $a;   ## $a = v(1); v(2); v(3);  <~~~> $a=do{local @_=(1); &v}; ... ?
  
  $a = ( v(1),(v(2),v(3)) );    say "S=(,,)", $a;   ## v(1); v(2); $a = v(3);
  
  $a = ( v(1),v(2)+v(3) );      say "S=(,+)", $a;   ## v(1); $a = ( v(2)+v(3) );
  
                                $, = $oldcomma;
},





sub {
       N 4                                            ;
  # ----------- print's return     function_name , (1)
  print 2, print 3, print 4;     #<~~~> ?

},





sub {
       N 5                                                                                        ;
 # ----------- unary+ f(,,)    .    "\n"    [10]0.1=[2]0.(0001)    ((+)+)!=(+(+))    = =    (=)++

#.1 ----
    say +(0.1 + 0.2 - 0.3)  . "\n" .  (0.2 - 0.3 + 0.1)  .  "\n";
    say  (0.1 + 0.2 - 0.3)  . "\n" .  (0.2 - 0.3 + 0.1)  .  "\n";       #<~~~> ?
    say'';

#.2 ----
    $b -= ($a = 1e10)++;                            #<~~~> $a = 1e10; {my $prev_a=$a; $a=$a+1; $b = $b - $prev_a;};

    say   $a+$b,   ' ',   2e-10 + $a + $b,   ' ',   $a + $b + 2e-10,  "\n";

#.3 ----------- use bigrat
  {
    use bigrat;   say  q(              after 'use bigrat':);
   
    say +(0.1 + 0.2 - 0.3)  . "\n" .  (0.2 - 0.3 + 0.1);
   
    say  $a+$b,   ' ',   2e-10 + $a + $b,   ' ',   $a + $b + 2e-10;
  };

},





sub {
       N 6                                                                    ;
# ----------- .. (in list context 1)    atan2() * / sin    function_name , (1)

    my $n1=4;    my $PI_part = 4*atan2(1,1)/$n1;

                        say  'x'        ,  "\t", 'sin(x)';
    for $_ (0..$n1) {   say  $_*$PI_part,  "\t",  sin($_*$PI_part);   }

	
# ----------- format    write

    format STDOUT_TOP =

@|||||||| @||||||||
'x',      'sin(x)'
.
format STDOUT =
@#.###### @#.######
$a,   $b
.
    for (0..$n1) {   $b = sin(  $a = $_*$PI_part  );   write   }

},






sub {
       N 7                                             ;
  # ----------- = ,    dualvar (1)    == eq    *= for

  $a='1.20',    $b='1.2'; 
  
  say  "$a eq $b"   if $a eq $b;
  say  "$a == $b"   if $a == $b;
  
  $_*=1  for $a,$b;     #<~~~>    {  local $_;   *_=\$a; $_=$_*1; (<~> $a=$a*1;)   *_=\$b; $_=$_*1; (<~> $b=$b*1;)  };
  
  say  "$a eq $b"   if $a eq $b;
  
},





sub {
       N 8                                             ;
  # ----------- ^     dualvar (2)
  
  $a='1',    $b=1;

  say  '$a^$a is TRUE'   if $a^$a;              #<~~~> ('1' ^ '1') && say ...; <~> "\x00" && say ...; <~> 1 && say ...;
  say  '$b^$b is TRUE'   if $b^$b;              #<~~~> 1^1;  <~> 0;
  say  '$a^$b is TRUE'   if $a^$b;              #<~~~> $a=$a*1; 1^1;
  say  '$a^$a is TRUE once more'   if $a^$a;    #<~~~> 1^1;

},





sub {
       N 9                                       ;
  # ----------- use Scalar::Util     dualvar (3)
  
  use Scalar::Util qw(dualvar);

  my $c = dualvar 10,'Hello!';
  
  say   0+$c,  ' <--n $c t--> ',  $c;

  # ----------- substr   ||
  say   substr($c,5,0,  ', world')   ||   ( substr($c,5,0) =  ', World' );   # <~~~> ?

  say   0+$c,  ' <--n $c t--> ',  $c;

},





sub {
       N 10                                                      ;
  # ----------- ():lvalue   =   closure   .(op) vs .(in number)
  {
    my $r;
    sub vr:lvalue{  say "vr:@_"; $r=' vr;';   $r  };

    sub f0(){  say "f0:@_";   ' f0;';  };
  };

    say '--- ',   f0.1,   vr.1;               #<~~~> ?

    say '=== ',   ''.vr,   vr,   vr=f0;       #<~~~> ?

},





sub {
       N 11                           ;
  # ----------- <*>    substr   -e

  my $nm = <*.pl>;                  #<~~~> opendir ...; do{$_=readdir(...)}while !/*.pl/; closedir(...); return $_;

  substr($nm,-1) = '';              #<~~~> ?
  
  say   "-e($nm):",  -e($nm).'l';   #<~~~> ...,  -e($nm.'l')

},





sub {
       N 12                                     ;
  # ----------- $,    .. (in list context (2))
  { local $,=',';
    say 'ca'..'dd';
  };

},





sub {
       N 13                                                         ;
  # ----------- $,   .. (in scalar context)   /txt/   grep    split
  { local $,=' ';
    say   grep  { !scalar(   /\(/ .. /\)/   ) }                         # <~~~> ask the lecturer
                    split ' ', 'Фжчко (бо Мжв) е кел (зор) гржечн.';    # <~~~> ask the lecturer
  };

},





sub {
       N 14                                     ;
  # ----------- x
  ...

},





sub {
       N 15                                     ;
  # ----------- || //
  ...

},





sub {
       N 16                                     ;
  # ----------- @=(?:)   @=@||@
  ...

},


);  #}=======================================================


my $d = new Demonstrator( $0, \@exs );
$d->work();


__END__

=head1 NAME

 ops.pl    - Demonstrator of Perl operations and operators.

There are an array of text examples in 'for'.

=head1 SYNOPSYS

 perl ops.pl        - to demonstrate all examples
 perl ops.pl N      - to demonstrate the N-th example
 perl ops.pl N1 N2  - to demonstrate the examples from N1 to N2

=cut

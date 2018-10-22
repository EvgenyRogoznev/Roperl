#!/usr/bin/env perl;
use strict;
use 5.010;

open (FIL, "<testEn.txt");
my @string=<FIL>; # передал в массив   @string текст построчно
my $note= @string.length; # определил количество  элементов массива $note

#создаем новый массив @theProcessedList  приводим строки к однообразию
#str_str_str_str..._num , убираесм строки без оценок
my @theProcessedList; 
for (my $i=0; $i < $note ;$i++ ){
    my$st=(join' ',(split ' ', $string[$i]));
    if((substr($st,-1)<=5) &&(substr($st,-1)>=2)){push(@theProcessedList,"$st");}
}
#print @theProcessedList;  #для контроля

#получить  список предметов
my @item;

sub itemGet{# функция вернёт из строки  название предмета в той строке
    my $str =$_[0];#  параметры будут переданы при вызове функции $str
   my @arra=(split ' ', $str);
   pop @arra;
    my @arra2=@arra[3..(@arra)];
}
#проверить на наличие предмета массиы @item если нет предмета то добавить

#получить список учеников









#for(my $i=0;$i<$note;$i++){
#our $name = join'',(split ' ', $string[$i],3); #будущее имя для хешей (имя фамилия отчество) слепленое
#our $name =
#our %var = (sss=>hj);
#%main::{$name} = \%var;}

#print "%main::blah\n";


#sub  criate{
#return 2;
# }
#!/usr/bin/env perl;
use strict;
use 5.010;
open (FIL, "< test.txt");
my @string=<FIL>; # передал в массив   @string текст построчно
my $note= @string.length; # определил количество  элементов массива $note
#создаем новый массив @theProcessedList  приводим строки к однообразию
#str_str_str_str..._num , убираем строки без оценок
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
return "$arra2[0] $arra2[1] ";
}
#print &itemGet($theProcessedList[2]);#Для проверки работы функции.
foreach my $a ( @theProcessedList ) {
our $predm= &itemGet($a);
#say $predm;

  if(!(grep( /^$predm$/,@item ))){#проверить на наличие предмета массив @item если нет предмета то добавить
     push (@item, $predm);}
}
#print @item.length;

sub GetStudents{# функция вернёт из строки  фамилию имя отчество
    my $str =$_[0];#  параметры будут переданы при вызове функции $str
   my @arra=(split ' ', $str);
   if(@arra.length>3) {
       pop @arra;
   }
return "$arra[0] $arra[1] $arra[2] ";
}
my@students;
foreach my $a ( @theProcessedList ) {
our $student= GetStudents($a);
#say $student;

  if(!(grep( /^$student$/,@students ))){#проверить на наличие предмета массив @students если нет студента то добавить
     push (@students, $student);}
}
#say @students;
#итого имеем массив всех существенных строк         @theProcessedList
#итого имеем массив всех предметов                  @item
#итого имеем массив всех имён                       @students
my @fivelist; # массив  5
for my $b (@theProcessedList){
if((substr($b,-1))==5){push (@fivelist, $b);}
}
my @bestStudent;

sub numberIn{#функция  считает сколько вхождений в массив @bestStudent было у переменной и возвращает их
my $str =$_[0];
my $in=0;
    for (my $i=0;$i<(@fivelist.length);$i++){
    if((index $fivelist[$i],$str)!=-1 ){$in+=1};
    }
return $in;
}
#print &numberIn($students[1]);
for my $best(@students){
    if (&numberIn($best)==@item.length){
        push @bestStudent,$best;
    }
}
say @bestStudent;




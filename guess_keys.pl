#!/usr/bin/perl
use IO::Socket::IP;
use IO::Select;

use GenKey;

my @l = ABC();
my (@socks, %state);

                    # Соединяемся с серверами ключей, формируя массив
                    # сокетов @socks и соответсвующих начальных состояний в $state{$socks[-1]}
for (@ARGV) {
    my $s = IO::Socket::IP->new(
                PeerHost => "127.0.0.1", PeerPort => $_,
                Type     => SOCK_STREAM, Family   => AF_INET
    );
    if ($@) {
        warn "Can't connect to $_";
        next;
    }; 
    $state{$s} = {l_idx => 0, key => '', port => $_, ans=>undef };
    $s->say('');
    push @socks, $s;
} 

                                            # Создаём объект для работы с массивом сокетов
my $select = IO::Select->new(@socks);

                                            # Общаемся с серверами до получения полного ключа от каждого
while ($select->handles) {
    my @s = $select->can_read(5);
    print "Timeout\n" and last unless @s;
  
    for my $s (@s) {                        # Для каждого, от которого можно получить ответ без блокировки,
        my $ok = change_state($s);          # получаем ответ и изменяем состояние,
        unless ($ok) {                      # и если ключ уже получен,
            $select->remove($s);            # удаляем соединение из общего списка
            print $state{$s}->{port}, ' => ', $state{$s}->{key}, "\n";
        }
    } 
}




sub change_state {
    my $s = shift;
                                        # Узнаём текущее состояние соединения
    my ($l_idx, $key, $ans) =
        @{$state{$s}}{qw/l_idx key ans/};
        
                                        # Получает ответ на предыдущий запрос
    my $answer = $s->getline();
    $answer += 0;
                                        # Полагагаем, что ответ для пустого запроса - это длина всего ключа,
    if ( !defined $ans ) {              # которую сохраним, чтобы узнать, угадали ли первую букву
        $state{$s}->{ans} = $answer;
        $s->say('A');
        return 1;
    };
    if ($answer == 0) {                 # Если не осталось неугаданных букв, то возвращаем завершающий код
        $state{$s}->{key} .= $l[$l_idx];
        return 0;
    };
    if ($answer < $ans) {               # При уменьшении числа неугаданных переходим к угадыванию следующей буквы
        $key .= $l[$l_idx];
        @{$state{$s}}{qw/l_idx key ans/} = (0, $key, $answer);
        $s->say("${key}A"); 
    
        return 1;
    }; 
  
    $state{$s}->{l_idx}++;              # При увеличении числа неугаданных меняем последнюю букву в проверяемом ключе
    $s->say(  $key . $l[$l_idx+1]  );
    return 1;
}

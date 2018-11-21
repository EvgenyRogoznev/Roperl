use IO::Socket::IP;

our $SERVERS_NUM    = 2;
our $ANSWER_DELAY   = 30;
our $LOCAL_PORT     = $ARGV[0] || 2017;


my $s = IO::Socket::IP->new(
            LocalAddr => '127.0.0.1', LocalPort => $LOCAL_PORT,
            Family => AF_INET, Type => SOCK_STREAM,
            Listen => 1, ReusePort => 1
        ) or die $@;

for (1..$SERVERS_NUM) {                     # Формируем серверы

    my $pid = fork;
    if ($pid) {
        #parent
    } else {                                # Простой сервер
        print "Start listen in $$\n";       #   Выдаем информацию об идентификаторе процесса
        while (1) {                         #   
            my $c = $s->accept();           #   Дождавшись канала для общения с клиентом,
            $c->say("$$ " . rand);          #   выдаём ему в ответ свой идентификатор и случайное число, а
            sleep $ANSWER_DELAY;            #   после некоторой задержки
            $c->close;                      #   закрываем канал.
        }
        exit 1; #no fork-bomb
    };

}

wait;                                       # Ожидаем, чтобы сформированные сервера не завершились

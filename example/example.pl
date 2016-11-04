    use Mojo::Zabbix::APP;

    my @myzinfo = <DATA>;    ##(get zabbix info from __DATA__ )

# Define for debug and traceing processe infomaition。（打开调试和跟踪）
    my $DEBUG = 0;
    my $TRACE = 0;

#my @myzinfo = ('test1  http://test1/zabbix    testuser pass');
# @可以定义为多行数据，格式按照这种，一个zabbix 服务地址一个

    for (@myzinfo) {
        next if /^#/;
        next if /^\s*$/;
        my ( $name, $url, $user, $pass ) = split;
        print "\n$name\n";
        my $z;

        eval { $z = initZ( $url, $user, $pss )};

        if ($@) {

            print "Error $@!\n";

        }
        else {
            ## Print the version of zabbix api. 打印zabbix 版本

            pVersion($z);

            ## Print all host lists。 获取所有的主机列表

            print getAllhost($z);

            ## Print warning info of Triggers。打印取得的所有触发器告警信息
            pTriggers($z);

            ## Print the history data of given items, default for past 24 hours.
            ## 打印给定时间段的item历史数据，如果默认不给时间默认为过去24小时内的
            pHitems($z);

        }

    }

__DATA__
test1            http://test1/zabbix    testuser pass
test2            http://test2/zabbix    testuser pass


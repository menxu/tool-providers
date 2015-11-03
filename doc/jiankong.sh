#! /bin/sh

mail_to=dd@funguide.com.cn
mail_cc=fff@funguide.com.cn
mail_from=mm@funguide.com.cn
#mail_opt="-- -f $from"
mail_subject="Alerting::disk_`/sbin/ifconfig eth0|grep -oP '(?<=addr:)[\d\.]+' || /sbin/ifconfig eth0 | grep -oP '(?<=地址:)[\d\.]+'`"

v=90

#while :
#do
#    sleep 600

    rm -f has_alerting_disk_*

    for i in  `df -h | awk '$(NF-1) ~/[0-9]%$/{print $(NF-1)}'|tr -d %`
    do
        if [ $i -ge "$v" ];then
            lack=`df -h | awk '$(NF-1) ~/[0-9]%$/{print "total",$(NF-4),"use",$(NF-3),"left",$(NF-2),$(NF-1),$NF}' | grep $i`
            [ ! -f has_alerting_disk_volume_mail`echo $lack|awk '{print $NF}'|sed 's/\//_/g'` ] && \
            /usr/local/sbin/sendEmail -t $mail_to -f $mail_from -cc $mail_cc -s smtp.exmail.qq.com -xu $mail_from -xp jiankong123 -u "$mail_subject" -m $lack && touch has_alerting_disk_volume_mail`echo $lack|awk '{print $NF}'|sed 's/\//_/g'` >/dev/null 2>&1
        fi
    done
exit

    for i in  `df -i | awk '$(NF-1) ~/[0-9]%$/{print $(NF-1)}'|tr -d %`
    do
        if [ $i -ge "$v" ];then
            inode=`df -i | awk '$(NF-1) ~/[0-9]%$/{print "total",$(NF-4),"use",$(NF-3),"left",$(NF-2),$(NF-1),$NF}' | grep $i`
            [ ! -f has_alerting_disk_inode_mail`echo $inode|awk '{print $NF}'|sed 's/\//_/g'` ] && \
            /usr/loca/sbin/sendEmail -t $mail_to -f $mail_from -cc $mail_cc -s smtp.exmail.qq.com -xu $mail_from -xp jiankong123 -u "$mail_subject" -m $inode && touch has_alerting_disk_inode_mail`echo $inode|awk '{print $NF}'|sed 's/\//_/g'` >/dev/null 2>&1
        fi
    done
#done

# */10 * * * * root /usr/local/sbin/monitor_disk.sh
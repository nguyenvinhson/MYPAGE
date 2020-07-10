#!/bin/bash
#----------------------------------------------------------------------------
# name : common.sh
#
# Description:
#   メール送信機能を提供する。
#
#----------------------------------------------------------------------------

# 起動中のシェルスクリプトファイル名
shell_name=`basename $0`

# スクリプトが実施出来るユーザの設定
run_user="appbat"

batch_server=batch201sse

# メールの設定
mail_from=enj_info@xxxx.ne.jp
mail_to="xxxx47@xxxx.ne.jp;xxxx15@xxxx.ne.jp;aaaa@xxxx.ne.jp"

# csvファイル添付ファイルとして送信する。
# (base64を利用）で添付
function Send_mail () {

if grep "ORA-" ${log_path}/data_down.log >/dev/null; then
    mail_subject="[ERR][SSE][DataLdr] Data DownLoad"
else
    mail_subject="[INFO][SSE][DataLdr] Data DownLoad"
fi

# setting
boundary=`date +%Y%m%d%H%M%N`

# mail header
echo "From: ${mail_from}
To: ${mail_to}
Subject: ${mail_subject}
MIME-Version: 1.0
Content-type: multipart/mixed; boundary=\"----$boundary\"
Content-Transfer-Encoding: 7bit
This is a multi-part message in MIME format.
" | nkf -w -Lu > ${tmp_path}/mail.tmp

## mail body
echo "------$boundary
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
" >> ${tmp_path}/mail.tmp

########
# 本文 #
########
echo "Detection time: `date '+%Y/%m/%d %H:%M:%S'`

`echo ${log_path}/data_down${boundary}.log`
-------------------------
`grep 全稼動情報 ${log_path}/data_down.log`
`grep 企業担当者情報 ${log_path}/data_down.log`
`grep 企業基本情報 ${log_path}/data_down.log`
`grep 事業所情報 ${log_path}/data_down.log`
`grep 部署情報出力 ${log_path}/data_down.log`
`grep スタッフ情報 ${log_path}/data_down.log`
`grep 案件情報 ${log_path}/data_down.log`
`grep 稼働情報 ${log_path}/data_down.log`
`grep スタッフ経歴情報 ${log_path}/data_down.log`
`grep 自己開発支援情報 ${log_path}/data_down.log`
`grep 報告書対象者情報 ${log_path}/data_down.log`
`grep SS担当者情報 ${log_path}/data_down.log`
`grep スタッフメールアドレス情報 ${log_path}/data_down.log`
`grep ＩＴスタッフメールアドレス情報 ${log_path}/data_down.log`

-------------------------

" | nkf -w -Lu >> ${tmp_path}/mail.tmp

## Send E-Mail
/usr/sbin/sendmail -i -f ${mail_from} ${mail_to} < ${tmp_path}/mail.tmp

## Delete TEMP file
rm -f ${tmp_path}/mail.tmp
mv ${log_path}/data_down.log ${log_path}/data_down${boundary}.log
}


# csvファイル添付ファイルとして送信する。
# (base64を利用）で添付
function Send_mail_db211ssj () {

# setting
boundary=`date +%Y%m%d%H%M%N`

# mail header
echo "From: ${mail_from}
To: ${mail_to}
Subject: ${mail_subject}
MIME-Version: 1.0
Content-type: multipart/mixed; boundary=\"----$boundary\"
Content-Transfer-Encoding: 7bit
This is a multi-part message in MIME format.
" | nkf -w -Lu > ${tmp_path}/mail.tmp

## mail body
echo "------$boundary
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
" >> ${tmp_path}/mail.tmp

########
# 本文 #
########
echo "Detection time: `date '+%Y/%m/%d %H:%M:%S'`
CPU Usage Alert. ${db_server}

CPU Threshold: ${time_cpu}%
NOW CPU      : ${total_cpu}%

Cacti data:
Date   : ${now_date}
System : ${now_system}%
User   : ${now_user}%
Nice   : ${now_nice}%
IOwait : ${now_iowait}%
-------------------------
Total  : ${total_cpu}%

" | nkf -w -Lu >> ${tmp_path}/mail.tmp

## Send E-Mail
/usr/sbin/sendmail -i ${mail_to} < ${tmp_path}/mail.tmp

## Delete TEMP file
rm -f ${tmp_path}/mail.tmp
}


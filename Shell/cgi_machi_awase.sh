#!/bin/sh
export JOBNAME=`basename $0`
cd `echo $0 |sed  "s/$JOBNAME//g"` && JOBDIR=`pwd`
export ULIB=$JOBDIR/../
. $ULIB/jobcom/com_environment
. $JOBTXT/xalande_webget_setting.txt
touch $JOBTXT/MachiAwase.txt
if [ "$1" = "" ] ;then
    echo "Error:パラメタ指定がありません。"
    exit 0
elif [ $(echo $1|grep -E "^https?://.*.\.*[a-zA-z/]$"|wc -l) -gt 0 ] ;then
    get_url=$1
else
    token=$1
fi
#-----------------------------------------------------------------
# トークンが無い場合はトークンを発行し、待ち合わせテーブルを入れて
# トークンを通知する
#-----------------------------------------------------------------
if [ "$token" = "" ] ;then
    while : ;do
        kari_toklen=$(tokern)
        if [ $(grep '$kari_toklen' $JOBTXT/MachiAwase.txt|wc -l) -eq 0 ];then
            token=$kari_toklen
            #-----------------------------------------------------------------
            # URLが不正なら終了
            #-----------------------------------------------------------------
            if [ $(echo $get_url|grep -E "^https?://.*.\.*[a-zA-z/]$"|wc -l) -eq 0 ] ;then
                echo "Error:URLが不正です。"
                exit 0
            fi
        #-----------------------------------------------------------------
        # 待ち合わせファイルに追加する
        #-----------------------------------------------------------------
        echo "$token<>$get_url" >> $JOBTXT/MachiAwase.txt
        printf "GetToken:$token"
        break
        fi
    done
else
    #-----------------------------------------------------------------
    # トークンを使った問い合わせ
    #-----------------------------------------------------------------
    if [ -f $KURAUDO_DIR/result/$token.result ] ;then
        cat $KURAUDO_DIR/result/$token.result
    else
        printf "NO RESULT"
    fi
fi

exit 0

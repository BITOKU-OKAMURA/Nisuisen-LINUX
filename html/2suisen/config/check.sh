for line_args in $(cat ./ORIKAESHI.list|sed 's@.2suisen@@g');do
[ $(ls -la ./*.2suisen|grep -c $line_args) -eq 0 ] && echo $line_args
done

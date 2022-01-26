for line_args in $(cat ./RPMS.txt) ;do
#yum search $line_args >> ./out1.txt
find /home/okamura/Packages/* -name "$line_args" >> ./out5.txt
#cp $line_args  ./RPMS/

done

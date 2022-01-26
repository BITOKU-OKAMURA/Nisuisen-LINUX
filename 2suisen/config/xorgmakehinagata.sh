url=$@
file=$(basename $url)
pkg=$(echo $file|sed 's@.tar.gz@@g'|sed 's@.tar.bz2@@g')
#echo $pkg.2suisen
echo "wget:$url" >> $pkg.2suisen 
echo "builed:eval \"cd /usr/src && XORGINST /usr/src/$file\"" >> $pkg.2suisen
echo "builed:clreandir" >> $pkg.2suisen
echo "complete" >> $pkg.2suisen
vi $pkg.2suisen
exit 0

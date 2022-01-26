#!/bin/sh
HTML_DIR="/home/sdl/public_html/gateweb.dip.jp/Document/"
/bin/rm -f $HTML_DIR/$FILE/index.html
echo "<html dir=\"ltr\" lang=\"ja\"><head><meta charset=\"UTF-8\"><title>system development tips (beta)</title></head><pre>" >> $HTML_DIR/index.html
cat $HTML_DIR/tecnoDocs.txt >> $HTML_DIR/index.html
echo "</pre></html>" >> $HTML_DIR/$FILE/index.html



#!/usr/bin/perl
#use strict;
use Jcode;
#my %param = map { /([^=]+)=(.+)/ } split /&/, $ENV{'QUERY_STRING'};
#ARGV[0]
my $QUERY = $ARGV[0];
$QUERY =~ s/\+/ /g;
$QUERY =~ s/%([0-9a-fA-F]{2})/pack("H2",$1)/eg;
my %param = map { /([^=]+)=(.+)/ } split /&/, $QUERY;
$sendmail = '/usr/sbin/sendmail'; 
$to = 'okamura@gateweb.dip.jp'; 
$from = 'info@kigyousupport.tokyo'; 
#$cc = 'y.okamura@jream.jp'; 
$subject = 'セキュリティ情報'; 
$msg = <<"_TEXT_";
セキュリティ情報が更新されています。
http://jvn.jp/
_TEXT_
$subject = jcode($subject)->mime_encode;
$msg =  Jcode::convert( $msg , "jis", "utf8" ); 
open(SDML,"| $sendmail -t -i") || die 'sendmail error';
print SDML "From: $from\n";
print SDML "To: $to\n";
#print SDML "Cc: $cc\n";
#print SDML "Reply-To: $param{'henshinn_mail'}\n";
print SDML "Subject: $subject\n";
print SDML "Content-Transfer-Encoding: 7bit\n";
print SDML "Content-type: text/plain;charset=\"ISO-2022-JP\"\n\n"; 
print SDML "$msg";
close(SDML); 

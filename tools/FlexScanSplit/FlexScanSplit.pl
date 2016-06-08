#!/usr/bin/perl -w

use strict;

#usage:  FlexScanSplit: generate xyz files for each point of G09 flex scan
#author:  programmed by perlcoder 
#date:   2016-06-08
#contact： 微信公众号 perlcoder   留言即可

my $templatexyz;   
my $scanlogfile;	  
if(@ARGV !=2)
{
   print "USAGE: \n";
   print "example:\nperl FlexScanSplit.pl   2a.xyz 2a.log\n";	
   print "programmed by perlcoder  weixin\n";
   die "check the command\n";
   
}
else
{
   $templatexyz=$ARGV[0];
   $scanlogfile=$ARGV[1];	
	
}

#flex scan -- Stationary point found.  $rigid scan Z-Matrix orientation:
#my $te='#AF3424DF  DF  CA$ #AF342 fsa fe435 t4 4DFDFCA$ #AF3424 DFDFCA$% #AF3424 DFDFCA$ #AF3424 DFDFCA$% ';
#my @results=$te=~/(#.*?$%)/g;

#flex scan
# Number     Number              X              Y              Z
# Optimization completed.
#  -- Stationary point found.


#################################got xyz template ###################################  
my @atoms;
my $index=0;
open FH,$templatexyz  or die "no xyz template file found\n";
while(<FH>)
{
   if($_=~/(\S+)\s+\S+\s+\S+\s+\S+/)	
   {
   	$index++;
   	$atoms[$index]=$1;
   	
   	
   	
   }
	
	
}
  
#print "index $index\n";    
      
      
###################################################################      
open FH,$scanlogfile or die "no file";
$/=undef;
my $text=<FH>;

#Number     Number       Type             X           Y           Z
my $string='Number     Number       Type             X           Y           Z';
my $end='Stationary point found';
my @segs=$text=~/((?<=$string)(?:(?!$string).)+?(?=$end))/msg;

#print $#segs;

my $confid=0;
foreach my $conf(@segs)
{
	$confid+=1;
	 my $file='2a_'.sprintf("%2d",$confid).'.xyz';
     my @lines=split(/\n/,$conf);
     my @mollines=@lines[2..$index+1];
     
  

	 writeconf($file,\@mollines,\@atoms);
	
	
	
	
}

sub writeconf
{
	my $file=$_[0];
	my @mol_lines=@{$_[1]};
	my @atoms=@{$_[2]};
	open FH,">$file";
	my $id=0;
	foreach my $line(@mol_lines)
	{
		$id++;
		   #   1        6           0.008966480   -0.001042623    0.001389385
		$line=~/(\d+)\s+\d+\s+\d+\s+(.*)/;
		print FH "$atoms[$1]           $2\n";
		
		
		
	}
	#print $id,"\n";
	close(FH);
	
	
}

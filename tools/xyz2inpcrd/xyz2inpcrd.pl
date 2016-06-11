#!/usr/bin/perl -w

use strict;

#usage:  xyz2inpcrd.pl  convert xyz file to inpcrd file
#example1:   perl xyz2inpcrd.pl  -f  1.xyz 
#examplex2:  perl  xyz2inpcrd.pl -F list.txt
#author:  programmed by perlcoder 
#date:   2016-06-08
#contact： 微信公众号 perlcoder   留言即可



my ($xyzfile,$listfile);

my $help;
use Getopt::Long qw(:config no_ignore_case bundling);

sub usage 
{
   my $message = $_[0];
   my $command = $0;
   print STDERR (
      $message,
      "usage: perl $command -f 1.xyz\n perl $command -F xyzlist.txt".
      "f: xyz file    ...\n" .
      "F: stort xyz file name in the text\n" .
      "example: you can download demo from  https://github.com/autodataming/QM/tree/master/tools \n"
   );

   die("\n")
}


GetOptions
(
'f=s'=>\$xyzfile,
'F=s'=>\$listfile,
'help!'=>\$help,

)
or usage( "Error in command line arguments");






#help should before the force option
if($help)
{
   usage("usage:
   ");	
}
 
 

my ($basename,$outname);
   
if(defined $xyzfile)
{
	($basename=$xyzfile)=~s/xyz//;
  	$outname=$basename.'inpcrd';
  
  	
   xyz2inpcrdfile($xyzfile,$outname);
	
	
}
elsif(defined $listfile)
{
	
	open FG,$listfile;
	while(<FG>)
	{
	  chomp;
	   my $xyzfile=$_;
	   
	   ($basename=$xyzfile)=~s/xyz//;
  	   $outname=$basename.'inpcrd';
  
  	
       xyz2inpcrdfile($xyzfile,$outname);
		
	}
	close (FG);
	
}
else
{
	
	usage("usage: \n");
	
	
}


sub xyz2inpcrdfile
{
   my $xyzfile=$_[0];
   my $output=$_[1];
   my @data;
   open FH,$xyzfile;
 #  O           0.446740    0.119652    0.827926
 #  C           1.486159    0.187127    1.738126
   
   
   my $xyz;
   my ($x,$y,$z);
   while(<FH>)
   {
   	 if($_=~/\S+\s+(\S+)\s+(\S+)\s+(\S+)/)
   	 {
   	     	$xyz=[$1,$2,$3];
   	     	push @data,$xyz;
   	 	
   	 }
   	
   }
   
   close(FH);
   
   
   open FF, ">$output";
   my $header="UCB";
   print FF "$header\n";
   my $num=@data;
   print FF "    $num\n";
   
   my $id=0;
   my $line;
   while(@data)
   {
   	     $line='';
    	$xyz=shift @data;
# 146.0610000  42.6020000  17.1520000 147.0880000  41.6350000  17.3320000
    	$x=sprintf("%12.7f",$xyz->[0]);
    	$y=sprintf("%12.7f",$xyz->[1]);
    	$z=sprintf("%12.7f",$xyz->[2]);
    	$line=$x.$y.$z;
    	$xyz=shift @data;
# 146.0610000  42.6020000  17.1520000 147.0880000  41.6350000  17.3320000
    	$x=sprintf("%12.7f",$xyz->[0]);
    	$y=sprintf("%12.7f",$xyz->[1]);
    	$z=sprintf("%12.7f",$xyz->[2]);
    	$line=$line.$x.$y.$z."\n";
    	print FF $line
    	
    	
   }
   
   close(FF);
    
	
		print "convert $xyzfile to $outname\n";
	
}







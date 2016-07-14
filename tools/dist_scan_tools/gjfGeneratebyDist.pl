#!/usr/bin/perl -w

#author: autolife
#contact: perlcoder weixin
#function: gen gjf files, by scan the distance between the acceptor and the donors
#usage: perl header.file move_seg.xyz 2 fixed_seg.xyz 11 2.9-3.5-0.2
#Notice: order is fixed. 
#         move_seg is the segment to move;
#test:   perl gjfGeneratebyDist.pl header.txt moved.xyz 2 fixed.xyz 11 5-1

my $usage= <<EOF;
#usage: perl header.file move_seg.xyz 2 fixed_seg.xyz 11 5-1
#Notice: order is fixed. 
#         move_seg is the segment to move;
          2 is the order in the move_seg label id
          fixed_seg.xyz;
EOF
#print $usage;

sub vec_calc
{
    my $atom1=$_[0];
    my $atom2=$_[1];
    my $dist=dist($atom1,$atom2);
    my $resu=[($atom2->[0]-$atom1->[0])/$dist,
              ($atom2->[1]-$atom1->[1])/$dist,
              ($atom2->[2]-$atom1->[2])/$dist,
               ];
      
    return $resu;	
	
}

sub dist
{
    my $atom1=$_[0];
    my $atom2=$_[1];
    my $resu=($atom2->[0]-$atom1->[0])**2+
              ($atom2->[1]-$atom1->[1])**2+
              ($atom2->[2]-$atom1->[2])**2;
    $resu=sqrt($resu);          
    return $resu;	
	
}
sub genfile
{
	my @header=@{$_[0]};
	my @fix_seg=@{$_[1]};
	my @move_seg=@{$_[2]};
	my $outfile=$_[3];
	open FH,">$outfile";
	print FH @header;
	    print FH "\n";
	print FH @fix_seg;
    print FH "\n";
	print FH @move_seg;
	close(FH);
	
}



sub updateseg
{
	my @seg=@{$_[0]};
	my $vec=$_[1];
	my @resu;
	foreach my $line(@seg)
	{
		my @elms=$line=~/(\S+)/gs;
		my ($x,$y,$z)=($elms[1]+$vec->[0],
		               $elms[2]+$vec->[1],
		               $elms[3]+$vec->[2],
		               );
	   $x=sprintf("%12.8f",$x);  $y=sprintf("%12.8f",$y);  $z=sprintf("%12.8f",$z);
	   my $newline=$elms[0].'    '.$x.'    '.$y.'    '.$z."\n";
	   push @resu,$newline;
	}
	return @resu;
	
	
}

sub updatevec
{
   my $vec_old=$_[0];
   my $result=[ $vec_old->[0]*$_[1],
                $vec_old->[1]*$_[1],
                $vec_old->[2]*$_[1],
              ];
  return $result;	
}



open FH, $ARGV[0] or die "can't find header file";
my @header=<FH>;
close(FH);

open FH, $ARGV[1] or die "can't find move_seg file";
my @move_seg=<FH>;
close(FH);
my $atom_line=$move_seg[$ARGV[2]-1];
my @atom_move_xyz=$atom_line=~/\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+/;

open FH, $ARGV[3] or die "can't find fixed_seg file";
my @fix_seg=<FH>;
close(FH);



$atom_line=$fix_seg[$ARGV[4]-1];
my @atom_fix_xyz=$atom_line=~/\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+/;



my $move_vec_normal=vec_calc(\@atom_fix_xyz,\@atom_move_xyz);
my $dist=dist(\@atom_fix_xyz,\@atom_move_xyz);

my ($step_num,$step_size)=$ARGV[5]=~/(\S+)\-(\S+)/;

while($step_num)
{
	my $outfile="out_".sprintf("%02d",$step_num).'.gjf';
	my $dist_add=$step_num*$step_size;
	my $move_vec=updatevec($move_vec_normal,$dist_add);
	my @move_segnew=updateseg(\@move_seg,$move_vec);
	genfile(\@header,\@fix_seg,\@move_segnew,$outfile);
	$step_num--;
}

print "finished , check results";
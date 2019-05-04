#!python

from log2xyz import log2xyz
from xyz2gjf import xyz2gjf
import fire 

def log2gjf(logfile,solvent="",charge=0,cpu=1,mem="1GB",kwords="# opt b3lyp/6-31g(d)"):
    log2xyz(logfile)
    # print "xyzfile obtained"
    xyzfile=logfile.replace('log','xyz')
    xyz2gjf(xyzfile,solvent,charge,cpu,mem,kwords)
    # print "gjffile obtained"



if __name__ == '__main__':
    # logfile="test.log"
    # log2gjf(logfile)
    fire.Fire(log2gjf)





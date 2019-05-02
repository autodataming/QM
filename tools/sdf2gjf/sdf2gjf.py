#!python

from sdf2xyz import sdf2xyz
from xyz2gjf import xyz2gjf
import fire 

def sdf2gjf(sdffile,solvent="",charge=0,cpu=1,mem="1GB"):
    sdf2xyz(sdffile)
    xyzfile=sdffile.replace('sdf','xyz')
    xyz2gjf(xyzfile,solvent,charge,cpu,mem)


if __name__ == '__main__':
    # sdffile="test.sdf"
    # sdf2gjf(sdffile)
    fire.Fire(sdf2gjf)





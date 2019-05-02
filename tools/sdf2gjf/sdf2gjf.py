#!python

from sdf2xyz import sdf2xyz
from xyz2gjf import xyz2gjf
import fire 

def sdf2gjf(sdffile):
    sdf2xyz(sdffile)
    xyzfile=sdffile.replace('sdf','xyz')
    xyz2gjf(xyzfile)


if __name__ == '__main__':
    # sdffile="test.sdf"
    # sdf2gjf(sdffile)
    fire.Fire(sdf2gjf)





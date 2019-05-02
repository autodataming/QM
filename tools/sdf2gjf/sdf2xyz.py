#!python2764

import sys
try:
    import pybel
except:
    print 'openbabel python-binding libraries named pybel not properly installed !'
    sys.exit(0)

def sdf2xyz(sdffile):
    mol = pybel.readfile("sdf", sdffile).next()
    xyzfile=sdffile.replace(".sdf",".xyz")
    #overwrite=True
    mol.write("xyz",xyzfile,overwrite=True)


if __name__=='__main__':
    sdffile="test.sdf"
    sdf2xyz(sdffile)





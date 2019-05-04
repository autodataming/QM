#!python2764

import sys
try:
    import pybel
except:
    print 'openbabel python-binding libraries named pybel not properly installed !'
    sys.exit(0)

def log2xyz(logfile):
    mol = pybel.readfile("g09", logfile).next()
    xyzfile=logfile.replace(".log",".xyz")
    #overwrite=True
    mol.write("xyz",xyzfile,overwrite=True)


if __name__=='__main__':
    logfile="test.log"
    log2xyz(logfile)





from log2gjf import log2gjf 
from glob import glob 
logfiles= glob("*.log")

for logfile in logfiles:
    log2gjf(logfile,kwords="# td(nstates=30,singlets)  b3lyp/6-31g(d)  scrf=(SMD,solvent=n-Hexane)")





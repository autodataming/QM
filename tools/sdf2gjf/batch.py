from sdf2gjf import sdf2gjf 
from glob import glob 
sdffiles= glob("*.sdf")

for sdffile in sdffiles:
    sdf2gjf(sdffile,solvent="n-Hexane")


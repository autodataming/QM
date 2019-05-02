#!python2764

from sdf2xyz import sdf2xyz
try:
    import fire 
except:
    raise "you should install fire befor run the script"

def xyz2gjf(xyzfile,solvent="",charge=0,cpu=1,mem="1GB"):
    '''
    '''
    chkfile=xyzfile.replace("xyz","chk")
    head1="%"+"nprocshared=%s\n"%cpu
    head2="%"+"mem=%s\n"%mem
    head3="%"+"chk=%s\n"%chkfile
    if solvent:
        head4="# opt b3lyp/6-31g(d) scrf=(smd,solvent=%s)\n"%solvent
    else:
        head4="# opt b3lyp/6-31g(d) \n"
    head5="\n"
    head6=xyzfile+" opt\n"
    head7="\n"
    head8="%s 1\n"%charge
    coord=''.join(open(xyzfile).readlines()[2:])+"\n\n\n\n"
    content=''.join([head1,head2,head3,head4,head5,head6,head7,head8,coord])
    gjffile=xyzfile.replace('xyz','gjf')
    open(gjffile,'w').write(content)

if __name__ =='__main__':
    fire.Fire(xyz2gjf)



#!python2764


try:
    import fire 
except:
    raise "you should install fire befor run the script"

def xyz2gjf(xyzfile,solvent="",charge=0,cpu=1,mem="1GB",kwords="# opt b3lyp/6-31g(d)"):
    '''
    '''
    chkfile=xyzfile.replace("xyz","chk")
    head1="%"+"nprocshared=%s\n"%cpu
    head2="%"+"mem=%s\n"%mem
    head3="%"+"chk=%s\n"%chkfile
    if solvent:
        head4="%s scrf=(smd,solvent=%s)\n"%(kwords,solvent)
    else:
        head4="%s \n"%(kwords)
    head5="\n"
    head6=xyzfile+" opt\n"
    head7="\n"
    head8="%s 1\n"%charge
    coord=''.join(open(xyzfile).readlines()[2:])+"\n\n\n\n"
    content=''.join([head1,head2,head3,head4,head5,head6,head7,head8,coord])
    gjffile=xyzfile.replace('xyz','gjf')
    # print content
    # print "gjffile",gjffile
    open(gjffile,'w').write(content)

if __name__ =='__main__':
    xyzfile="test.xyz"
    xyz2gjf(xyzfile)
    fire.Fire(xyz2gjf)



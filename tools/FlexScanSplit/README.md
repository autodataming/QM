
http://sobereva.com/164
具体怎么解决优化不收敛得看实际情况，特别是要用gview检查优化过程的轨迹，看是否最后开始震荡了（如果能量还在降低则应当继续跑下去）。虽然上面讨论了很多，但从实用性出发，对于初学者笔者推荐按照以下顺序去尝试解决震荡问题：
1 对于DFT，特别是明尼苏达系列泛函（如M062X、M06、M06L），首先加上int=ultrafine再试。
2 如果体系小，尝试opt=calcall。如果体系大算得慢，此关键词会令计算量进一步激增，实在没辙再考虑这个。
3 尝试opt=gdiis。
4 尝试opt(gdiis,maxstep=x,notrust)，x为3~5。


flex scan, some point may not optimization stopped.
```
         Item               Value     Threshold  Converged?        
 Maximum Force            0.019760     0.000450     NO             
 RMS     Force            0.001615     0.000300     NO             
 Maximum Displacement     0.092911     0.001800     NO             
 RMS     Displacement     0.018550     0.001200     NO             
 Predicted change in Energy=-2.674223D-04                          
 Optimization stopped.                                             
    -- Number of steps exceeded,  NStep= 239                       
    -- Flag reset to prevent archiving.   
    
```

flex scan, Stationary point found

```
         Item               Value     Threshold  Converged?
 Maximum Force            0.000008     0.000450     YES
 RMS     Force            0.000002     0.000300     YES
 Maximum Displacement     0.000866     0.001800     YES
 RMS     Displacement     0.000168     0.001200     YES
 Predicted change in Energy=-2.705818D-09
 Optimization completed.
    -- Stationary point found.
```
---------------------------------
遇到opt不成功的点，
- 提取不成功点的构象，进行限制二面角优化。

-output
```
F:\wja\14151617>perl FlexScanSplit.pl  2a.xyz  AT-ligand_opt_14151616_-92d_s10new.log  AT1415
1617_-92_
segs have  1+36
the point id 12 is not stationary point, you make better optimized it again
the point id 31 is not stationary point, you make better optimized it again
37 confs have extracted form the log file
```

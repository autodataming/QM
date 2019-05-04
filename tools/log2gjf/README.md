# 功能： 把高斯的输出log文件转化成 gjf文件
# 依赖
1. python27 推荐anaconda安装python
2. pybel(openbabel) 推荐用anacond 安装该模块

# 用法：
#### 批量处理
step1. 把脚本放到log文件夹里面
step2. 运行batch.py 就可以把该文件夹下的所有log 转化为gjf 文件

默认是
准备计算ECD的gjf 文件

# 处理一个文件
pythonanapy27.exe .\log2gjf.py test.log --kwords "# td(nstates=30,singlets)  b3lyp/6-31g(d)  scrf=(SMD,solvent=n-Hexane)"




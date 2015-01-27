# semantic-diff
source code diff tool with semantic comparison

##设计方案
设计方案主要分为两部分实现：
 1. 使用gcc编译源代码文件，生成中间语法树结果，并建立语法树行号与源码的行号之间的关系，然后作函数差异对比，将差异对应回源文件的差异比较中。
 2. 根据差异中变更的行，找到宏的使用情况，然后去头文件中找到定义的宏的位置。
 
##实现
 1. 根据调研，最好的结果是使用.cfg，原因是该中间结果既可以不附带变量相关的编号，也可以加入行号相关的信息，而对标签相关的结构关系，则通过文本差异对比已经清楚的显示了，只要结合把两种差异起来显示，就能得到全面的结果。而且，加入行号以后的cfg文件的行与不加入行号cfg的行是不变的，可以轻易地建立语法树与源文件行号的对应关系。至此，就已经可以生成带有语法的结合版差异显示了。（已完成）
 2. 根据资料查询，并没有找到gcc可以回溯查询宏定义的位置。这个问题其实可以具体为两个子问题：
  1. 找到哪行使用了宏
  2. 如何找到这个宏的定义，及其嵌套的宏定义位置

 第一个问题解决的方法可以使用.i与.c文件对比，找到宏展开的行，然后解析出宏。可能的问题是.i的格式是否与.c格式相同，可能有其他干扰信息。
 
 第二个问题解决的方法，根据第一种方法找到的宏，使用grep -nR去相关头文件目录去找定义,可能的问题是：可能有多个宏定义相关，ifdef等等多个位置。


<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../../../index.html"><i class="fas fa-home"></i></a>/<a href="../../../index.html">数据结构</a>/<a href="../../index.html">labs</a>/<a href="../index.html">2018</a>/<a href="index.html">Polynomial</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/数据结构/labs/2018/Polynomial" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><i class="fas fa-meh"></i>&nbsp;None</li></ul>

## Files
<ul><li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/数据结构/labs/2018/Polynomial/main.cpp"><i class="fas fa-file-code"></i>&nbsp;main.cpp---(4.24K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/数据结构/labs/2018/Polynomial/Makefile"><i class="fas fa-file"></i>&nbsp;Makefile---(170.00B)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/数据结构/labs/2018/Polynomial/poly.cpp"><i class="fas fa-file-code"></i>&nbsp;poly.cpp---(3.21K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/数据结构/labs/2018/Polynomial/poly.hpp"><i class="fas fa-file"></i>&nbsp;poly.hpp---(921.00B)</a></li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<h1 id="_1">多项式计算器</h1>
<p>使用示例：</p>
<pre class="codehilite"><code>❯ make
g++    -c -o poly.o poly.cpp
g++    -c -o main.o main.cpp
#clang++ poly.o main.o -o main.out
clang++  poly.o main.o -o main.out
❯ ./main.out
q to quit, new to create new poly, print to print polys stored, delete to delete a poly, add sub mul eval to do operations
poly&gt; new
New poly: (enter 1 2 3 0 for +1x^(2)+3x^(0))
1 2 3 0
Your poly: +1x^2+3x^0
poly&gt; n
New poly: (enter 1 2 3 0 for +1x^(2)+3x^(0))
2 2 1 1
Your poly: +2x^2+1x^1
poly&gt; mul
Enter two indexes: 1
2
Multiplication is: +2x^4+1x^3+6x^2+3x^1
Result saved
poly&gt; poly&gt; print
Total 3 Polys: 
#1: +1x^2+3x^0
#2: +2x^2+1x^1
#3: +2x^4+1x^3+6x^2+3x^1
poly&gt; eval
Enter a index: 3
Enter an x value: 99
The value of poly +2x^4+1x^3+6x^2+3x^1 when x is 99 is: 1.93149e+08
poly&gt; poly&gt; q
</code></pre>

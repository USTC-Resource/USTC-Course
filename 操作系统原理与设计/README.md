
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../index.html"><i class="fas fa-home"></i></a>/<a href="index.html">操作系统原理与设计</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/操作系统原理与设计" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><a href="exams/index.html"><i class="fas fa-folder"></i>&nbsp;exams</a></li>
<li><a href="homeworks/index.html"><i class="fas fa-folder"></i>&nbsp;homeworks</a></li>
<li><a href="labs/index.html"><i class="fas fa-folder"></i>&nbsp;labs</a></li>
<li><a href="notes/index.html"><i class="fas fa-folder"></i>&nbsp;notes</a></li></ul>

## Files
<ul><li><i class="fas fa-meh"></i>&nbsp;None</li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<h1 id="h">计算机系统(H)</h1>
<p><a href="https://osh-2018.github.io">osh-2018 课程主页</a></p>
<p>实验很有趣, 还有详细的教程,有兴趣的同学可以做一做</p>
<h1 id="2018">2018 期末试卷回忆</h1>
<blockquote>
<p>by secon</p>
</blockquote>
<p>第一部分是概念题，比较简单，抄书即可，但是有些反例需要自己想，书和 PPT 都没有，主要如下：（不全，因为脑细胞都死在最后一题上了，记不清了……）</p>
<p>概念 PCB FCB 优先级 程序 进程 管程
举几个反例 如基于平均周转周期和最大等待时间的调度算法在什么情况下会产生冲突 总共三个
内存分配的算法的优劣性
地址查找的范围以及与其相关的文件最大大小（有点绕）
什么时候多线程不比单线程效率高？
有些反例课上讲过，老师上课挺有意思，信息量比较大，注意记下有用的东西。</p>
<p>第二部分更加简单 ，大部分是考的应用型：（依旧不全）</p>
<p>让你用信号量处理一个互斥问题 抄书就行；
用 LRU 算法、FIFO 算法、最优算法的缺页次数、然后比较；
分析内存的分配如果溢出可能出现的问题，就是当你 copy 了一个长度大于 malloc 的空间的字符串会出现什么样子的问题。
 还有题目是对局部性进行考察，就是让你分析一个程序的缺页次数和效率的问题。
磁盘读写的电梯算法和 FCFS 算法的执行过程。</p>
<p>第三大题 基于一个比较现实的模型来分析系统的运行模式，本次考试的模型是短时间内的大量并发访问（双十一、世界杯），并以此来分析操作系统的模型。</p>
<p>第一题是问一个请求，多个进程处理 如何实现互斥；</p>
<p>第二题问如何采用进程池和连接池来实现效率优化；</p>
<p>第三题和第四题是分别问阻塞型进程和非阻塞进程在处理大量并发请求时的不同表现</p>
<p>第五题是问一个进程执行完后通过线性查找来寻找空闲 socket 的方式，这种方式在大量请求时会出什么问题。</p>
<p>最后有两道附加题共八分，因此卷面满分 108 分，问两种浏览器服务器模型的执行上的优劣性的原因，个人感觉时上面第三大题的综合 其中很多机制在上面都有解释，不难。</p>

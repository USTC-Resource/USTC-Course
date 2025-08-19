
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../../index.html"><i class="fas fa-home"></i></a>/<a href="../../index.html">编译原理和技术</a>/<a href="../index.html">labs</a>/<a href="index.html">2019-licheng</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/编译原理和技术/labs/2019-licheng" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><a href="lab1_lexical_analyzer/index.html"><i class="fas fa-folder"></i>&nbsp;lab1_lexical_analyzer</a></li>
<li><a href="lab2_syntax_analyzer/index.html"><i class="fas fa-folder"></i>&nbsp;lab2_syntax_analyzer</a></li>
<li><a href="lab3-0/index.html"><i class="fas fa-folder"></i>&nbsp;lab3-0</a></li>
<li><a href="lab3-1/index.html"><i class="fas fa-folder"></i>&nbsp;lab3-1</a></li>
<li><a href="lab3-2/index.html"><i class="fas fa-folder"></i>&nbsp;lab3-2</a></li>
<li><a href="lab4/index.html"><i class="fas fa-folder"></i>&nbsp;lab4</a></li></ul>

## Files
<ul><li><i class="fas fa-meh"></i>&nbsp;None</li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<h1 id="2019labs">2019秋李诚老师编译原理Labs</h1>
<p>古宜民 17少 (https://github.com/ustcpetergu) </p>
<p>队友：苏文治，朱凡</p>
<p>Labs for "Principles and Techniques of Compilers" course by Cheng Li, USTC 2019. 
 <code>lab1_lexical_analyzer</code>: Lab1, lexical analyzer, using flex
 <code>lab2_syntax_analyzer</code>: Lab2, syntax analyzer, using bison and lab1, from source code to syntax tree
 <code>lab3-0</code>: Warmup about LLVM code generation
 <code>lab3-1</code>: The main CMinus Compiler: syntax tree to LLVM IR
 <code>lab3-2</code>: Source code reading report for LLVM Pass(dce and adce)
 <code>lab4</code>: RISC-V machine code generation and execution &amp; LLVM RegAllocFast source code reading</p>
<p>因为2019秋的Labs很多都是基于七位助教提供的框架补充内容/继续开发，很多Tutorial和Instruction均不是我们原创，并且当时项目目录结构就比较混乱，在我们的开发后更加混乱，想要运行代码有一定难度：所以这里在保持一学期项目完整度的情况下尽可能只放了我们原创的内容，包括主代码文件，工作和讨论记录，以及实验报告。</p>
<p>代码文件只能阅读，不具备运行条件。相比之下实验报告参考价值更大一些。每个lab的实验要求在实验报告里有总结。</p>
<p>学期后我整理了lab1、lab2、lab3-1的代码（词法分析，语法分析，语法树到IR）成为一整个可以比较方便地运行和继续开发(立了个flag)的repo，在<a href="https://github.com/ustcpetergu/CminusC">ustcpetergu/CminusC</a>。Bug肯定是有的，但应该不多了（助教的样例测试分数98/100）。</p>
<p>该学期的课程主页：http://210.45.114.30/gbxu/notice_board/issues</p>

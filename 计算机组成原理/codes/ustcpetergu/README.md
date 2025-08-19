
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../../index.html"><i class="fas fa-home"></i></a>/<a href="../../index.html">计算机组成原理</a>/<a href="../index.html">codes</a>/<a href="index.html">ustcpetergu</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/计算机组成原理/codes/ustcpetergu" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><a href="ip/index.html"><i class="fas fa-folder"></i>&nbsp;ip</a></li>
<li><a href="lab1/index.html"><i class="fas fa-folder"></i>&nbsp;lab1</a></li>
<li><a href="lab2/index.html"><i class="fas fa-folder"></i>&nbsp;lab2</a></li>
<li><a href="lab3/index.html"><i class="fas fa-folder"></i>&nbsp;lab3</a></li>
<li><a href="lab4/index.html"><i class="fas fa-folder"></i>&nbsp;lab4</a></li>
<li><a href="lab5/index.html"><i class="fas fa-folder"></i>&nbsp;lab5</a></li>
<li><a href="lab6/index.html"><i class="fas fa-folder"></i>&nbsp;lab6</a></li>
<li><a href="mips-bubble/index.html"><i class="fas fa-folder"></i>&nbsp;mips-bubble</a></li></ul>

## Files
<ul><li><i class="fas fa-meh"></i>&nbsp;None</li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<h3 id="2020-cod">2020 年春季学期 COD 实验报告 &amp; 代码</h3>
<p>原项目/历史记录请见 https://github.com/ustcpetergu/USTC-COD-Labs/</p>
<ul>
<li>Lab1: ALU &amp; sort</li>
<li>Lab2: Regfile &amp; RAM &amp; FIFO</li>
<li>Lab3: Single cycle CPU</li>
<li>Lab4: Multiple cycle CPU</li>
<li>Lab5: 5-stage pipeline CPU</li>
<li>Lab6: CPU &amp; UART on ebaz4205 (testing video in report.md)</li>
</ul>
<p>Rebuild projects from TCL(for example):</p>
<pre class="codehilite"><code>vivado -mode batch -source lab6.tcl -tclargs --project_name lab6
</code></pre>


<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../../index.html"><i class="fas fa-home"></i></a>/<a href="../../index.html">数理逻辑</a>/<a href="../index.html">codes</a>/<a href="index.html">mbinary</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/数理逻辑/codes/mbinary" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><a href="src/index.html"><i class="fas fa-folder"></i>&nbsp;src</a></li></ul>

## Files
<ul><li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/数理逻辑/codes/mbinary/system_L.py"><i class="fas fa-file-code"></i>&nbsp;system_L.py---(13.65K)</a></li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<blockquote>
<p>写的一个简单的脚本实现 在 L 下的公式证明, 有兴趣的同学可以看看, 算是抛砖引玉吧</p>
</blockquote>
<h1 id="system-l">system-L</h1>
<h2 id="descripton">Descripton</h2>
<p>it's a formal logic deduction based on system-L</p>
<h3 id="symbols">symbols</h3>
<p><code>~</code> , <code>-&gt;</code>  (in the script, i use &gt; to repr it)</p>
<h3 id="rules">rules</h3>
<p>The basic three axioms:
* L1: <code>p-&gt;(q-&gt;p)</code>
* L2: <code>(p-&gt;(q-&gt;r)) -&gt; ((p-&gt;q)-&gt;(p-&gt;r))</code>
* L3: <code>~q-&gt;~p -&gt; (p-&gt;q)</code></p>
<h3 id="deduction">deduction</h3>
<p>{p,p-&gt;q} |- q</p>
<p>you can read the professional <a href="src/mathematical-logic.pdf">book</a>
or click <a href="https://en.wikipedia.org/wiki/Mathematical_logic">here</a> to see more details </p>
<h2 id="idea">Idea</h2>
<p>To prove one proposition:
* Firstly, I use deduction theorem(演绎定理) to de-level the formula and finally get a prop varible or a prop in form of <code>~(...)</code>. let's  mark it as p or ~p
* Next, I create a set <code>garma</code> and fill it with  some generated  formulas using the three axioms(公理),some theorem and conclusions.
* Then, I search p or ~p in <code>garma, or further, using modus ponent(MP) to deduct  p or ~p.
* Finally, if using mp can't prove it, I will use</code>Proof by contradiction`(反证法) to prove it.</p>
<h2 id="requirement">Requirement</h2>
<p>python modules
* sympy</p>
<h2 id="visual">Visual</h2>
<p><img alt="" src="src/sys-L.png" /></p>
<h2 id="to-do">To do</h2>
<ul>
<li>将证明过程对象化,便于处理,打印(英文版,中文版),</li>
<li>其他连接词的转换</li>
<li>处理简单的, 有一定模式的自然语言, 形成命题推理</li>
</ul>
<h2 id="contact">Contact</h2>
<ul>
<li>mail: zhuheqin1@gmail.com</li>
<li>QQ  : 414313516</li>
</ul>

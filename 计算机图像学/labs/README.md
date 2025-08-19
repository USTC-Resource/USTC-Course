
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../index.html"><i class="fas fa-home"></i></a>/<a href="../index.html">计算机图像学</a>/<a href="index.html">labs</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/计算机图像学/labs" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><a href="cpp/index.html"><i class="fas fa-folder"></i>&nbsp;cpp</a></li>
<li><a href="result/index.html"><i class="fas fa-folder"></i>&nbsp;result</a></li></ul>

## Files
<ul><li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/计算机图像学/labs/dft.py"><i class="fas fa-file-code"></i>&nbsp;dft.py---(2.93K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/计算机图像学/labs/lab1.py"><i class="fas fa-file-code"></i>&nbsp;lab1.py---(3.24K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/计算机图像学/labs/lab2.py"><i class="fas fa-file-code"></i>&nbsp;lab2.py---(4.17K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/计算机图像学/labs/lab3.py"><i class="fas fa-file-code"></i>&nbsp;lab3.py---(1.82K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/计算机图像学/labs/lab4.py"><i class="fas fa-file-code"></i>&nbsp;lab4.py---(1.00K)</a></li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>
<h1 id="2019"><div align="center">2019 计算机图像学实验</div></h1>
<blockquote>
<p>说明. 最开始我用的 cpp 实现了实验内容(代码在 <code>cpp</code>目录下）。但是配置 opencv 环境失败，代码只经过了静态语法检测，可能还有些地方有 bug。 后来我用的 python 重新实现了所有算法，并将结果记录如下</p>
</blockquote>
<h2 id="11">1.1. 使用</h2>
<h3 id="111">1.1.1. 环境</h3>
<ul>
<li>python3.6+</li>
<li>matplotlib</li>
<li>numpy</li>
<li>cv2</li>
</ul>
<h3 id="112">1.1.2. 运行</h3>
<p>当前目录下的所有 python 代码按如下格式执行</p>
<p><code>python3 lab*.py &lt;IMG_PATH&gt;</code></p>
<p>如</p>
<p><code>python3 lab1.py images/lena.bmp</code></p>
<div align="center"><h1>实验内容</h1>  </div>

<h2 id="21">2.1. 图像的点处理</h2>
<h3 id="211">2.1.1. 灰度的线性变换</h3>
<p>输入斜率，截距， 进行一维线性变换</p>
<h3 id="212">2.1.2. 灰度拉伸</h3>
<p>输入两个转折点(x1,y1),(x2,y2), 进行分段的线性变换</p>
<pre class="codehilite"><code>当 x&lt;x1, f(x) = y1/x1*x
当 x1&lt;=x&lt;=x2, f(x) = (y2-y1)(x-x1)/(x2-x1)+y1
当 x&gt;x2, f(x) = (255-y2)*(x-x2)/(255-x2)+y2
</code></pre>

<h3 id="213">2.1.3. 灰度直方图</h3>
<p>输入图像，显示它的灰度直方图, 还可以输入恢复的上限，下限， 显示这个范围内的灰度直方图</p>
<h3 id="214">2.1.4. 直方图均衡</h3>
<p>扩大灰度范围，减少灰度之间的数量差值</p>
<p>结果如下
<img alt="" src="result/lab1-lena.png" /></p>
<p><img alt="" src="result/lab1-pout.png" /></p>
<h2 id="22">2.2. 数字图像的平滑</h2>
<p>滤波，去除图像的噪声,均值滤波，中值滤波去除加性噪声；同态滤波去除乘性噪声</p>
<p>先给图像加上 3% 的椒盐噪声，然后分别使用 窗口大小为 3 的均值滤波器和中值滤波器进行滤波</p>
<p>记图像大小 nxm, 窗口大小为 wxw
我在实现滤波器时，移动窗口，每次只会更新移进的值，和移出的值。
即 窗口先又移动，每移动一列，就将这列的数据考虑进来，而将移出的那一列剔除。<strong>这样在更新窗口的值时只需 O(w)</strong>。 而如果直接更新整个窗口，需要 O(w*w)</p>
<p>对于均值滤波，时间复杂 O(nmw)
对于中值滤波，需要求出中值，则这需要 O(w^2) 的时间才能完成。可以利用 快速选择的算法，在O(lengthOfArray) 时间里找出排任意名次的数，这里找出中值, w*w/2
总时间复杂度 O(nmw^2)</p>
<p>结果如下
<img alt="" src="result/lab2-lena.png" /></p>
<h2 id="23">2.3. 图像的边缘检测</h2>
<p>实验原理： </p>
<p>在灰度图像的情况下，所谓的边缘检测可以看成是基于图像像素灰度值在空间的不连续性对图像做出的一种分割。边缘可以用方向和幅度两个特性来描述。一般而言，沿边缘走向方向其幅度值变化较平缓，而沿垂直于边缘走向其幅度值变化较剧烈。 </p>
<p>经典的边缘提取方法是考察图像的每个像素在某个邻域内灰度的变化，利用边缘邻近一阶或二阶方向导数变化规律，用简单的方法检测边缘。这种方法称为边缘检测局部算子
法。 </p>
<p>边缘检测算子一般有
- Roberts 交叉算子
- Sobel 模板卷积
- Prewitt 同上
- Laplace </p>
<p>对于具体实现，需要注意的是 像素值的类型，以及参与的运算。例如 python 中，像素值类型为 <code>uint8</code>， 直接相加减可能造成 溢出， 结果在 mod 256 的域中, 所以在可能出现溢出的情况下，我在前面用 <code>0+</code> 后面的结果，这样可以将类型提升为 int 的运算而不会出现溢出。</p>
<p>我实现了 Roberts, Prewitt， 结果如下
<img alt="" src="result/lab3-lena.png" />
<img alt="" src="result/lab3-map.png" /></p>
<h2 id="24">2.4. 傅里叶变换</h2>
<p>实验要求
- 对 <code>images/rect*</code> 图像作二维Fourier , 显示频谱，然后作幅度变换，将低频移到中心点
- Fourier 反变换 幅度，并显示
- Fourier 反变换 相位，并显示</p>
<p>实现的思路是：
- 首先实现 一维的变换 fft, ifft。 </p>
<ul>
<li>
<p>使用 快速傅里叶算法 fft,对每一层， 计算倒序数，进行计算，一个 log(n) 层，每一层计算 n次， 则一维 fft时间复杂度为 <code>O(nlog(n))</code></p>
</li>
<li>
<p>然后利用傅里叶变换的可分离性，计算二维 傅里叶变换 fft2, ifft2: 先对每行进行一维变换, 然后对每列进行一维变换。</p>
</li>
</ul>
<p>傅里叶变换的总结可见<a href="https://mbinary.xyz/dft.html">我的这篇文章</a></p>
<p>结果如下</p>
<p><img alt="" src="result/lab4-rect1.png" />
<img alt="" src="result/lab4-rect2.png" /></p>

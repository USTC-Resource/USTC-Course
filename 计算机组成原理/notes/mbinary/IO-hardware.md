---
title: 『现代操作系统』IO硬件原理
tags: [操作系统]
mathjax: false
date: 2018-06-16 20:57:27
categories:
        - 操作系统
keywords:
description: "io 硬件原理, 设备控制器, 内存映射, DMA"
top:
---

**I/O 硬件原理**

<!-- TOC -->

- [0.1. I/O 设备](#01-io-设备)
    - [0.1.1. 块设备(block device)](#011-块设备block-device)
    - [0.1.2. 字符设备(character device)](#012-字符设备character-device)
- [0.2. 设备控制器(device controller / adapter)](#02-设备控制器device-controller--adapter)
- [0.3. 内存映射 I/O](#03-内存映射-io)
    - [0.3.1. 方案](#031-方案)
    - [0.3.2. 工作原理](#032-工作原理)
    - [0.3.3. 优点](#033-优点)
    - [0.3.4. 缺点](#034-缺点)
- [0.4. DMA(直接存储器存取, Direct Memory Access)](#04-dma直接存储器存取-direct-memory-access)
    - [0.4.1. 工作原理](#041-工作原理)
    - [0.4.2. 对 CPU 的延迟](#042-对-cpu-的延迟)
        - [0.4.2.1. 周期窃取(Cycle Stealing)](#0421-周期窃取cycle-stealing)
        - [0.4.2.2. 突发模式(burst mode)](#0422-突发模式burst-mode)
- [0.5. 中断](#05-中断)
    - [0.5.1. 问题](#051-问题)
        - [0.5.1.1. 哪些信号需要保存?](#0511-哪些信号需要保存)
        - [0.5.1.2. 保存在哪里?](#0512-保存在哪里)
        - [0.5.1.3. 谁来保存?](#0513-谁来保存)
        - [0.5.1.4. 考虑流水线,超标量(内部并行)](#0514-考虑流水线超标量内部并行)

<!-- /TOC -->

<a id="markdown-01-io-设备" name="01-io-设备"></a>
## 0.1. I/O 设备

<a id="markdown-011-块设备block-device" name="011-块设备block-device"></a>
### 0.1.1. 块设备(block device) 
把信息存储在固定大小的块中,每个块都有自己的地址. 每个块可以独立于其他块读写. 如 硬盘, CD-ROM , USB 盘 ...

<a id="markdown-012-字符设备character-device" name="012-字符设备character-device"></a>
### 0.1.2. 字符设备(character device)
字符设备以字符为单位发送或接收一个字符流, 而不考虑任何块结构. 它是不可寻址的.
如打印机,网络接口, 鼠标(用作指点设备)...

<a id="markdown-02-设备控制器device-controller--adapter" name="02-设备控制器device-controller--adapter"></a>
## 0.2. 设备控制器(device controller / adapter)
I/O 设备一般由两部分组成: 机械部分和电子部分.
电子部分就是设备控制器. 常以插入(PCI)扩展槽中的印刷电路板的形式出现.

控制器与设备之间的接口是很低层次的接口. 它的任务就是把串行的位流转换为字节块,并进行必要的错误校正.

<a id="markdown-03-内存映射-io" name="03-内存映射-io"></a>
## 0.3. 内存映射 I/O
每个控制器有几个寄存器, OS 可以读写来了解,更改设备的状态信息. 控制器还有 OS 可以读写的 **数据缓冲区**.

问题来了: CPU 如何与设备的控制寄存器和数据缓冲区通信.
<a id="markdown-031-方案" name="031-方案"></a>
### 0.3.1. 方案
* 方法一: 每个控制寄存器被分配一个 I/O   端口(所有端口形成端口空间,受保护不被普通用户访问).  然后可以设置指令来读写, 

如 `IN REG, PORT `将读取控制器寄存器 PORT 中的内容到 CPU 寄存器 REG

* 方法二: 内存映射 I/O. 将所有控制寄存器映射到内存空间, 都被分配唯一的地址, 且这些内存地址不会再分配. 

![](https://upload-images.jianshu.io/upload_images/7130568-fdf890cee3067484.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-032-工作原理" name="032-工作原理"></a>
### 0.3.2. 工作原理
CPU 读入一个字时, 不论是从内存还是 I/O 端口, 都将目的地址放在总线的地址线上, 总线控制线置 READ 信号看. 还要用一条线表明是 I/O 空间 还是内存空间. 如果是 I/O空间, I/O设备将响应请求.
<a id="markdown-033-优点" name="033-优点"></a>
### 0.3.3. 优点
* 如果需要特殊的 I/O 指令读写设备控制寄存器,那么访问这些寄存器需要使用汇编代码, 调用这样的过程需要增加开销,

对于`内存映射 I/O  ,设备控制寄存器只是内存中的变量, 和其他变量一样寻址,可以用 C 语言编写驱动程序

* 对于内存映射 I/O , 不需要特殊的保护机制来阻止用户进程执行 I/O 操作. 操作系统只需注意不要将内存映射的地址映射到用户虚拟地址空间. 更有利的是, 如果有多个设备, 可以将内存映射 I/O 映射到不同的页, 可以分配特定的页给用户,使其使用驱动程序, 而且不担心各驱动程序之间的影响


<a id="markdown-034-缺点" name="034-缺点"></a>
### 0.3.4. 缺点
* 不能对设备控制器的寄存器进行 cache, 因为设备的状态改变, 软件将没有办法发现. 所以硬件必须对每个页面具备选择性的禁用 chche. 增加了复杂性


* 在内存映射机器上, 具有单独的内存总线会使 I/O 设备没有办法查看内存地址,因为内存地址旁路到内存总线上, 没有办法响应.


<a id="markdown-04-dma直接存储器存取-direct-memory-access" name="04-dma直接存储器存取-direct-memory-access"></a>
## 0.4. DMA(直接存储器存取, Direct Memory Access)
独立于 CPU 访问系统总线


![](https://upload-images.jianshu.io/upload_images/7130568-5f38b735de855118.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-041-工作原理" name="041-工作原理"></a>
### 0.4.1. 工作原理
![](https://upload-images.jianshu.io/upload_images/7130568-80b9d28961f38fc1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

也就是不用浪费 CPU 处理缓冲区到内存的时间, 相当于另有一个" CPU " 专门处理 磁盘 到 内存 的 I/O

<a id="markdown-042-对-cpu-的延迟" name="042-对-cpu-的延迟"></a>
### 0.4.2. 对 CPU 的延迟
<a id="markdown-0421-周期窃取cycle-stealing" name="0421-周期窃取cycle-stealing"></a>
#### 0.4.2.1. 周期窃取(Cycle Stealing)
注意 上面的操作是字模式传送,  在 DMA 请求传送一个字并且得到这个字时, CPU 不能使用总线,必须等待.

<a id="markdown-0422-突发模式burst-mode" name="0422-突发模式burst-mode"></a>
#### 0.4.2.2. 突发模式(burst mode) 
上面是字传输模式, 对于块模式下的传送, DMA 会发起一连串的传送,然后才释放总线. 这比周期窃取效率更高.

上面 的模式是` 飞越模式(fly-by mode)`, 即 DMA 控制器直接通知设备控制器将数据传送到 主存, 只请求一次总线

某些 DMA 使用其他模式. 让设备控制器将字发送到 DMA, 然后 DMA 再 请求总线将数据发送到其他地方(其他设备, 主存...), 这样会多消耗一个总线周期, 但是更加灵活: 可以 `设备->设备`, `内存->内存`(内存读, 然后 内存写)


不使用 DMA 的考虑:
* CPU 比 DMA 快得多,当限制因素不是  I/O 设备的读写速度时,没必要使用 DMA
* 去除 DMA 而用 CPU 使用软件做所有工作可以节省硬件的开销


<a id="markdown-05-中断" name="05-中断"></a>
## 0.5. 中断
当一个 I/O 设备完成它的工作后,它就产生一个中断, 通过在分配给它的一条总线信号线上置起信号.
![中断](https://upload-images.jianshu.io/upload_images/7130568-e3b42e4a79067659.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果有多个中断请求, 按优先级, 如果还没有被处理, 设备一直发出中断知道得到 CPU 服务

中断控制器通过在地址先上放置一个数字`(中断向量  interrupt vector)`表明哪个设备需要关注,同时向 CPU 发出中断

中断信号导致 CPU 停止当前工作, 并处理其他事情.  根据中断向量跳转到需要的中断服务程序

<a id="markdown-051-问题" name="051-问题"></a>
### 0.5.1. 问题
开始中断服务之前, 硬件需要保存信息
<a id="markdown-0511-哪些信号需要保存" name="0511-哪些信号需要保存"></a>
#### 0.5.1.1. 哪些信号需要保存?
至少程序计数器, 至多可见的寄存器, 一些内部寄存器...
<a id="markdown-0512-保存在哪里" name="0512-保存在哪里"></a>
#### 0.5.1.2. 保存在哪里?
* 如果放在内部寄存器, 那么中断控制器之后无法得到应答,知道所有可能的相关信息被读出,以免第二个中断重写内部寄存器保存状态. 这样在中断被禁止时将导致长时间的死机,并可能丢失中断和数据
* 如果在堆栈中, 使用谁的堆栈? 

  * 如果使用当前堆栈, 可能是用户进程的,堆栈指针可能是不合法的.  
  * 可能指向一个页面的末端, 若干次内存写之后, 可能超出页面发生页面故障. 那么在何处保存状态以处理页面故障?
  * 如果用内核堆栈. 切换到和心态可能要求改变 MMU 上下文, 并且可能使 cache 和 TLB 的大部分失效. 静态地或动态地重新状态所有东西将增加处理一个中断的时间,因而浪费 CPU 的时间
<a id="markdown-0513-谁来保存" name="0513-谁来保存"></a>
#### 0.5.1.3. 谁来保存?
对谁可见就谁来保存

<a id="markdown-0514-考虑流水线超标量内部并行" name="0514-考虑流水线超标量内部并行"></a>
#### 0.5.1.4. 考虑流水线,超标量(内部并行)
在流水线满的时候,如果出现一个中断, 由于许多指令处于不同的正在执行的截断. 程序计数器可能无法正确反应已经执行的指令和未执行之间的边界. 
在超标量机器上, 指令可能分解成微操作, 为操作可能乱序执行
* 精确中断(precise interrupt):将机器留在一个明确状态

![](https://upload-images.jianshu.io/upload_images/7130568-6d3109af89d731da.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/7130568-1cb12ad8c6b1d535.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 不精确中断(imprecise interrupt)

不满足上面的条件

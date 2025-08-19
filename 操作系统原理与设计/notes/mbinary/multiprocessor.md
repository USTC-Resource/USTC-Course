---
title: 『现代操作系统』多处理机
date: 2018-06-09 10:33:25
tags: [操作系统,读书笔记]
categories: 
        - 操作系统
keywords: 
description:

---

<!-- TOC -->

- [多处理机简介](#多处理机简介)
- [多处理机硬件](#多处理机硬件)
    - [UMA(Uniform Memory Access)](#umauniform-memory-access)
        - [基于总线的UMA多处理机体系结构](#基于总线的uma多处理机体系结构)
        - [基于交叉开关的UMA多处理机](#基于交叉开关的uma多处理机)
        - [基于多级交换的UMA多处理机](#基于多级交换的uma多处理机)
    - [NUMA(nonuniform memory access)](#numanonuniform-memory-access)
    - [多核芯片](#多核芯片)
<!-- more -->
- [多处理机操作系统类型](#多处理机操作系统类型)
    - [每个 CPU 都有自己的操作系统](#每个-cpu-都有自己的操作系统)
    - [主从多处理机](#主从多处理机)
    - [对称多处理机(Symmetric MultiProcessor, SMP)](#对称多处理机symmetric-multiprocessor-smp)
- [多处理机调度](#多处理机调度)
    - [分时](#分时)
    - [空间共享](#空间共享)
    - [群调度( Gang Scheduling)](#群调度-gang-scheduling)
        - [基本思想](#基本思想)
        - [调度方法](#调度方法)
- [参考资料](#参考资料)

<!-- /TOC -->

<a id="markdown-多处理机简介" name="多处理机简介"></a>
# 多处理机简介
![](https://upload-images.jianshu.io/upload_images/7130568-773a443f335b74e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 共享存储器多处理机

每个cpu都可同样访问

* 消息传递多计算机

通过某种高速互联网络连接在一起, 每个存储器局部对应一个cpu, 且只能被该cpu访问,这些cpu 通过互联网络发送多字消息通信
易于构建, 编程难

* 广域分布式系统

通过广域网连接,如Internet, 

 多处理机是共享存储器多处理机的简称,多个cpu共享一个公用的RAM.
<a id="markdown-多处理机硬件" name="多处理机硬件"></a>
# 多处理机硬件
所以多处理机都具有每个cpu可访问全部存储器的性质,而有些多处理机有一些特性,
<a id="markdown-umauniform-memory-access" name="umauniform-memory-access"></a>
## UMA(Uniform Memory Access)
读出每个存储器字的速度一样快
<a id="markdown-基于总线的uma多处理机体系结构" name="基于总线的uma多处理机体系结构"></a>
### 基于总线的UMA多处理机体系结构
![bus](https://upload-images.jianshu.io/upload_images/7130568-abbf038a92f33edf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<a id="markdown-基于交叉开关的uma多处理机" name="基于交叉开关的uma多处理机"></a>
### 基于交叉开关的UMA多处理机
![](https://upload-images.jianshu.io/upload_images/7130568-31d968eeecb9ed8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<a id="markdown-基于多级交换的uma多处理机" name="基于多级交换的uma多处理机"></a>
### 基于多级交换的UMA多处理机
![开关](https://upload-images.jianshu.io/upload_images/7130568-bddb3d547d70ad8a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![原理](https://upload-images.jianshu.io/upload_images/7130568-19f2ce23be62c183.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
此开关检查module域来决定连入哪个存储器, 即连接x还是y

例如 `Omega网络`
![](https://upload-images.jianshu.io/upload_images/7130568-25bceeb447cf27fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
n个cpu/存储器, 有 log<sub>2</sub>n级, 每级只需n/2个开关, 
![](https://upload-images.jianshu.io/upload_images/7130568-fcdc9660c10718b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


比较: 

网络|开关数|是否阻塞
:-:|:-:|:-:
交叉开关|n<sup>2</sup>|不阻塞
Omega网络|n/2*log<sub>2</sub>n|阻塞

<a id="markdown-numanonuniform-memory-access" name="numanonuniform-memory-access"></a>
## NUMA(nonuniform memory access) 
特性:
* 具有对所有cpu都可见的单个地址空间
* 通过 LOAD 和 STORE 指令来访问运程存储器
* 访问远程存储器慢于访问本地存储器


**基于文件的多处理机**
基本思想: 维护一个数据库来记录告诉缓存行的位置及其状态. 当一个高速缓存行被引用时,就查询数据库找出高速缓存行的位置以及它的dirty记录,(是否被修改过), 
<a id="markdown-多核芯片" name="多核芯片"></a>
## 多核芯片
每个核就是一个完整的 CPU , 可以共享内存, 但是 cache 不一定共享. 时常被成为 **片级多处理机**`(Chip-level MultiProcessors, CMP)`. 

与基于总线的多处理机和使用交换网络的多处理机的差别不大:
* 基于总线的 每个CPU 都有自己的cache
* CMP容错性低: 连接紧密, 一个共享模块的失效可能导致其他 CPU 出错


**片上系统** (system on a chip)
芯片包含多个核,但是同时还包含若干个专业核, 比如视频与音频解码器, 加密芯片,网络接口等

<a id="markdown-多处理机操作系统类型" name="多处理机操作系统类型"></a>
# 多处理机操作系统类型
<a id="markdown-每个-cpu-都有自己的操作系统" name="每个-cpu-都有自己的操作系统"></a>
## 每个 CPU 都有自己的操作系统
优点: 共享操作系统代码

![](https://upload-images.jianshu.io/upload_images/7130568-718f915e6e179171.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**注意**
* 在一个进程进行系统调用时,是在本机的 CPU 上被捕获并处理的,并使用操作系统表中的数据结构
* 因为每个操作系统都有自己的表,那么也有自己的进程集合, 通过自身调度这些进程,而没有进程共享. 如果一个用户登陆到 CPU1 , 那么他的进程全在 CPU1 上, 也就是可能导致其他CPU 空载
* 没有页面共享: 可能出现 CPU2 不断进行页面替换而 CPU1 却有多余的页面
* cache 不一致

<a id="markdown-主从多处理机" name="主从多处理机"></a>
## 主从多处理机
![主从多处理机](https://upload-images.jianshu.io/upload_images/7130568-81ecda735dab03b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**问题**
如果有很多 CPU , 主 CPU 会成为瓶颈, 速度慢
<a id="markdown-对称多处理机symmetric-multiprocessor-smp" name="对称多处理机symmetric-multiprocessor-smp"></a>
## 对称多处理机(Symmetric MultiProcessor, SMP)
![](https://upload-images.jianshu.io/upload_images/7130568-499c2694ee01e54c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

消除了主从处理机的不对称性, 在存储器中有操作系统的一个副本, 但任何 CPU 都可以运行它. 

这个模型动态平衡进程和存储器, 因为它只有一套操作系统数据表. 
它存在的问题: 当两个或多个 CPU 同时运行操作系统代码时, 如请求同一个空闲存储器页面,这时应该使用互斥信号量(锁),使整个系统成为一大临界区. 这样在任一时刻只有一个 CPU 可运行操作系统

<a id="markdown-多处理机调度" name="多处理机调度"></a>
# 多处理机调度
调度对象: 单进程还是多进程, 线程是内核进程还是用户线程.  
* 用户线程: 对内核不可见,那么调度单个进程,.
* 内核线程: 调度单元是线程,

<a id="markdown-分时" name="分时"></a>
## 分时

![单一数据结构调度](https://upload-images.jianshu.io/upload_images/7130568-e42d431ecff83552.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

先讨论调度独立线程的情况, 如果有 CPU 空闲则选择优先级队列中的最优先线程到此 CPU

缺点:
* 随着 CPU 数量增加引起对调度数据结构的潜在竞争
* 当线程在 I/O 阻塞时引起上下文切换的开销(overhead)


亲和调度: 基本思想, 尽量使一个线程在它前一次运行过的 CPU 上运行, 

<a id="markdown-空间共享" name="空间共享"></a>
## 空间共享

![](https://upload-images.jianshu.io/upload_images/7130568-260392d6f43eef9a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当线程之间以某种方式彼此相关时, 可以使用此方法. 假设一组相关的线程是一次性创建的,  创建时, 检查是否有足够的空闲 CPU, 有 则 各自获得专用的 CPU, 否则等待,

优点: 消除了多道程序设计, 从而消除上下文切换开销
缺点: 当CPU被阻塞或根本无事可做时时间被浪费了
<a id="markdown-群调度-gang-scheduling" name="群调度-gang-scheduling"></a>
## 群调度( Gang Scheduling)
![](https://upload-images.jianshu.io/upload_images/7130568-9179b61a8caa35f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-基本思想" name="基本思想"></a>
### 基本思想
让一个进程的所有线程一起运行, 这样互相通信更方便,在一个时间片内可以发送和接收大量的消息.
<a id="markdown-调度方法" name="调度方法"></a>
### 调度方法
* 把一组相关线程作为一个单位,即一个群, 一起调度
* 一个群中的所有成员在不同的分时 CPU 上同时运行
* 群中的所有成员共同开始和结束其时间片


![示例](https://upload-images.jianshu.io/upload_images/7130568-e0a5fbe1cface447.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<a id="markdown-参考资料" name="参考资料"></a>
# 参考资料
1. 现代操作系统
2. [Multi-Processor Systems | UCLA](https://lasr.cs.ucla.edu/classes/111_fall16/readings/multiprocessor.html)

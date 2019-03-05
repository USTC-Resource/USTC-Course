---
title: 『现代操作系统』IO软件原理
tags: [操作系统]
mathjax: false
date: 2018-06-16 20:57:27
categories:
        - 操作系统
keywords:
description:
top:
---

<!-- TOC -->

- [IO软件目标](#io软件目标)
- [IO处理方式](#io处理方式)
- [IO软件层次](#io软件层次)
    - [中断处理程序](#中断处理程序)
    - [设备驱动程序](#设备驱动程序)
        - [位置](#位置)
        - [功能](#功能)
        - [运行](#运行)
    - [与设备无关的I/O软件](#与设备无关的io软件)
    - [用户空间的IO软件](#用户空间的io软件)

<!-- /TOC -->
<!-- more -->

<a id="markdown-io软件目标" name="io软件目标"></a>
# IO软件目标
* 设备独立性(device independence): 编写的程序能够访问任何设备而无需事先指定. 即程序的通用性
* 统一命名(uniform naming): 一个文件或一个设备的名字应该是一个简单的字符串或数字. 
* 错误处理(error handling): 错误应该尽可能接近硬件得到处理.  处理不了再上传
* 同步(synchronous) 和 异步(asynchronous)(即中断驱动): 大都数物理 I/O 是  异步的


<a id="markdown-io处理方式" name="io处理方式"></a>
# IO处理方式
* 程序控制 I/O

让 CPU 做全部 I/O工作,成为程序控制 I/O
CPU 要不断地查询设备, 这成为 `polling` 或 `busy waiting`
* 中断驱动 I/O

缺点是 中断发生在每个事件上, 同样要花一些时间,
如打印一个缓冲区的字符, 每个字符都要中断一次
* 使用DMA

需要特殊的硬件 DMA 控制器, 每个缓冲区中断一次

<a id="markdown-io软件层次" name="io软件层次"></a>
# IO软件层次
![](https://upload-images.jianshu.io/upload_images/7130568-15e38d5c0266b3ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-中断处理程序" name="中断处理程序"></a>
## 中断处理程序
![中断发生时软件需要做的](https://upload-images.jianshu.io/upload_images/7130568-8a083e447a046fde.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<a id="markdown-设备驱动程序" name="设备驱动程序"></a>
## 设备驱动程序


每个连接到计算机上的 I/O 设备都需要某些设备特定的代码来对其进行控制 , 注意 设备控制器是硬件上的, 驱动程序是软件上的. 

![](https://upload-images.jianshu.io/upload_images/7130568-4db40de87e2d9454.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-位置" name="位置"></a>
### 位置
为了访问设备的硬件(即设备控制器的寄存器), 设备驱动程序需要是系统内核的一部分. 

其实也可以构造运行在用户空间的驱动程序,使用系统调用来读写设备寄存器. 这样可以使内核与驱动程序,  驱动程序之间隔离, 消除驱动程序干扰内核造成的系统崩溃.

<a id="markdown-功能" name="功能"></a>
### 功能
* 接收来自其上方与设备无关的软件发出的抽象的读写请求
* 如果需要, 驱动程序 必须对设备进行初始化,还可能对电源需求和日志事件进行管理

<a id="markdown-运行" name="运行"></a>
### 运行
驱动程序在执行期间动态地装在到系统
![](https://upload-images.jianshu.io/upload_images/7130568-49e9705b0b160924.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/7130568-978e1aca394e0122.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/7130568-b054c4666b855453.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<a id="markdown-与设备无关的io软件" name="与设备无关的io软件"></a>
## 与设备无关的I/O软件
**功能**
* 缓冲

![](https://upload-images.jianshu.io/upload_images/7130568-fd1901f63a7e4c69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 错误报告
* 分配与释放专用设备
* 提供与设备无关的块大小
* 设备驱动程序的统一接口

<a id="markdown-用户空间的io软件" name="用户空间的io软件"></a>
## 用户空间的IO软件
* C 语言中的 printf


* 假脱机(spoolilng)

如果一个进程打开它, 然后很长时间不使用, 则其他进程都无法打印 .  另外一种方法是   创建一个 `守护进程(daemon)` 和` 假脱机目录`. 一个进程要打印一个文件时, 首先生成要打印的整个文件, 并且放在假脱机目录, 由守护进程打印该目录下的文件, ,,守护进程是唯一允许使用打印机特殊文件的进程.

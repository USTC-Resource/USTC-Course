---
title: 『Unix环境高级编程』linux 文件 I/O
date: 2018-06-09 23:33:25
tags: [linux,操作系统,读书笔记]
categories: 
        - 操作系统
---

# 文件描述符
非负整数, 默认使用最小的可用的整数
0,1,2  对应 STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO
<!-- more -->

# 读写函数
`#include<unistd.h>`
*  int open(const char *path,int oflag ... /*mode*/);flag: 必须选1: O_RDONLY, O_WRONLY, O_RDWR, O_SEARCH, O_EXEC

    可选: O_APPEND, O_CREAT, O_EXCL, O_SYNC, O_TRUNC	eg   O_WDONLY | O_CREAT | O_TRUNC
    * int close(int fd);
    * off_t  lseek(int fd, off_t offset, int whence)hence:  SEEK_SET, SEEK_CUR, SEEK_END   错误则返回-1ffset 可负, 可以超过文件大小, 在超过文件大小后写,会形成空洞, 用\0填补,但是不占用磁盘块
    *  ssize_t read(int fd, void *buf,size_t nbytes);ﬁ未到EOF,则读取nbytes,返回nbytes, 否则剩多少,读多少,返回多少(到EOF就是0)
    *  ssize_t write(int fd, void *buf,size_t nbytes);*io效率**: buf设置为4096及更大效率较高

# 进程文件结构
    ![image.png](https://upload-images.jianshu.io/upload_images/7130568-41de9a42f1c26214.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

    ![image.png](https://upload-images.jianshu.io/upload_images/7130568-88491773353c7aa6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 文件共享
    ![image.png](https://upload-images.jianshu.io/upload_images/7130568-bb62bdea0df113e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
# 原子操作
    一般有多个函数的操作,, 不是原子操作, 多进程运行时可能出错,比如
    ```
    seek pointer  to end
    write
    ```
    单进程没有问题, 而多进程访问同一个文件, 而不是同一个文件描述符时, 比如a,b访问f
    当a执行完seek到end后 ,写指针在n, b执行seek to end 然后写至x bytes,此时文件指针已经到n+x,  但是a会在n处继续执行写,然后就覆盖了bxx的内容

# 复制文件描述符dup   dup2
    ```
#include<unistd.h>
    int dup(int fd); // copy fd
    int dup2(int fd,int fd2)
    // close fd2 and open fd,  note it's  an atomic op
    //if  fd2==fd : return fd2
    ```
    ![image.png](https://upload-images.jianshu.io/upload_images/7130568-5a24c92f20e687e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


    参考资料: UNIX环境高级编程 W.Richard Stevens, Stephen A. Rago

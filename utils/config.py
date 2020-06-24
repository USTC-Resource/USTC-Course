# coding: utf-8
import os.path

HOST = 'https://raw.githubusercontent.com/'
OWNER = 'USTC-Resource'  #'USTC-Courses'  #'mbinary'#
REPO = 'USTC-Course'
BRANCH = 'master'
NAME = 'README.md'  # index.html

PATH = os.path.join(HOST, OWNER, REPO, BRANCH)

WALKDIR = os.path.abspath('.')

TARDIR = 'docs'
if not os.path.exists(TARDIR):
    TARDIR = 'docs'

IGNORE = ['utils', 'docs', '__pycache__', '_config.yml','images']

DOWNLOAD = 'http://downgit.zhoudaxiaa.com/#/home?url=https://github.com/' + OWNER + '/' + REPO + '/tree/' + BRANCH + '/'

HTML = '''
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/{cur}
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="{DOWNLOAD}" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul>{dirLst}</ul>

## Files
<ul>{fileLst}</ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

{readme}
'''

#* 非zip, 非以'.'开头的文件多于 3 个的目录下都有个 zip 文件：`-DIRECTORY 目录下的\d+个文件.zip`,包含当前目录下的一些文件, 这样方便大家一键下载. (在 git commit前, 运行 `./before__commit.sh`可以自动生成)

README = r'''
![](images/logo.png)

# 中国科学技术大学课程资源

[![Stars](https://img.shields.io/github/stars/USTC-Resource/USTC-Course.svg?label=Stars&style=social)](https://github.com/USTC-Resource/USTC-Course/stargazers)
[![Forks](https://img.shields.io/github/forks/USTC-Resource/USTC-Course.svg?label=Forks&style=social)](https://github.com/USTC-Resource/USTC-Course/network/members)
[![build](https://github.com/USTC-Resource/USTC-Course/workflows/build/badge.svg)]()
[![repo-size](https://img.shields.io/github/repo-size/USTC-Resource/USTC-Course.svg)]()
[![License](https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

>>本仓库收录中国科学技术大学众多课程资源的笔记，总结，经验等**学生原创内容**

# 目录索引
* [版权说明](#版权说明)
* [反馈方式](#反馈方式)
* [资料下载](#资料下载)
* [课程结构](#课程结构)
* [课程关系](#课程关系)
* [课程目录](#课程目录)
* [贡献投稿](#贡献投稿)

# 版权说明
本仓库分享资料遵守其创作者之规定, 由同学自愿投稿，仅接收学生原创的或者获得授权的资源。

对无特别声明的资料，谨以[知识共享署名 - 非商业性使用 - 相同方式共享 4.0 国际许可协议](http://creativecommons.org/licenses/by-nc-sa/4.0/) 授权。![](https://i.creativecommons.org/l/by-nc-sa/4.0/80x15.png)

请创作者及公众监督，如有资料违反许可协议，请告知我们改正错误。

# 反馈方式
- [issue](https://github.com/USTC-Resource/USTC-Course/issues/new)
- <a href="mailto:&#122;huheqin1@gmail.com?subject=USTC-Course-FeedBack">email</a>

# 资料下载
[戳我(●'◡'●)](https://ustc-resource.github.io/USTC-Course)

<!--
## FTP
1. FTP/FTPS:
   - 地址：ftp.ustclug.org；
   - 路径：/ebook/USTC-CS-Courses-Resource；
   - 用户名：ftp；
   - 密码：ftp；
2. SFTP (Secure File Transfer Protocol):
   - 地址：ftp.ustclug.org；
   - 路径：/ebook/USTC-CS-Courses-Resource；
   - 用户名：ftp；
   - 密码：ftp；
3. AFP (Apple Filing Protocol)
   - 地址：afp://ftp.ustclug.org/；
   - 路径：/ebook/USTC-CS-Courses-Resource；
   - Connect As Guest

感谢 @USTC-LUG, @[zzh1996](https://github.com/zzh1996), @[volltin](https://github.com/volltin)


## HTTPS

- [GitHub 网页](#课程目录)
- [DownGit](http://downgit.zhoudaxiaa.com/#/home)
- [gitzip-chrome-extension](https://chrome.google.com/webstore/detail/gitzip-for-github/ffabmkklhbepgcgfonabamgnfafbdlkn)

注意，建议不要直接用 GitHub 仓库的 `Download Zip`。因为网速慢，而且仓库很大，很可能下载到中途就切断连接了。
推荐用 DownGit 工具，方法很简单，在 GitHub 这里浏览网页到某个文件夹，然后将这个网页地址粘贴到 DownGit 下载即可。

-->

# 课程结构
每门课程大致结构如下，有些栏目可能没有，也可以自己添加认为合理的栏目
```
course
├ codes
│   ├ mbinary0
│   ├ mbinary1
│   └ mbinary2
├ labs
├ exams
├ notes
└ README.md
```
# 课程关系
![](images/course.png)

更多信息可以下载[官网的培养方案](https://www.teach.ustc.edu.cn/education/241.html/attachment/14-215%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%AD%A6%E9%99%A2-2013)

# 课程目录
**根据拼音字母排序**, 可以通过在此页面搜索课程名快速定位。

{index}

# 贡献投稿

>感谢您的贡献 :smiley:

- 仅接受学生原创的或者获得授权的资源
- GitHub 上不能直接上传大于 100Mb 的文件。对于超过 100 Mb 的文件，可以存在网盘，然后在 README.md 中贴上链接
- 文件内容的改动会使 git 重新上传, 在没有必要的情况下, 不要对二进制文件做任何更改.

<!--
可以通过如下方式贡献
- 帮忙上传: 可以发给仓库维护者帮忙上传，或者提 issue
- 用网页操作或者[桌面版](https://desktop.github.com/) fork and pull request. 操作方式可以参考 [这里](https://blog.csdn.net/qq_29277155/article/details/51048990) 和[这里](https://blog.csdn.net/zhangw0_0/article/details/50667891),[PR](https://blog.csdn.net/huutu/article/details/51018317)

- 用命令行: 注意仓库较大,直接 clone 很慢. 可以使用 sparse-checkout, 只下载指定的目录
执行
```shell
mkdir ustc-courses  #文件夹名可以自己取
cd ustc-courses
git init
git remote add -f origin  git@github.com:mbinary/USTC-CS-Courses-Resource.git
git config core.sparsecheckout true
echo "计算机与信息类/软件工程"  >> .git/info/sparse-checkout  #这里工作目录就是在那个 repo 主页下

#如果还有其他目录，都像上面一样加入即可，如 `echo  "计算机与信息类/图论/slides" >> .git/info/sparse-checkout`
#只需记住的是 加入的目录应该在远程仓库存在，否则报错“error: Sparse checkout leaves no entry on the working directory”

git pull origin master
git remote add upstream git@github.com:mbinary/USTC-CS-Courses-Resource.git
```
更新内容后
```shell
git fetch upstream/master
git merge upstream/master
```
-->

'''

# coding: utf-8
import os.path

HOST = 'https://raw.githubusercontent.com/'
OWNER = 'mbinary' #'USTC-Courses'  #'mbinary'#
REPO = 'USTC-CS-Courses-Resource'
BRANCH = 'master'


PATH = os.path.join(HOST,OWNER,REPO,BRANCH)


WALKDIR = os.path.abspath('.')

indexFileDirDic = {'/mnt/d/blogfile/blog/source/ustc-cs':'index.html','docs':'README.md'}

IGNORE = ['utils','docs']

HTML = '''

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link href="https://mbinary0.github.io/resource/github.markdown.css" rel="stylesheet">
  </head>
  <body>
     	<div><h2>
                <a href="../index.html">&nbsp;&nbsp;<i class="fa fa-level-up"></i>&nbsp;&nbsp;</a>:
                /{cur}
            </h2>
        <div><span> 根据拼音排序</span></div>
        </div>
        <h2>Directories</h2>
        <ul>
        {dirLst}
        </ul>

        <h2>Files</h2>
        <ul>
        {fileLst}
        </ul>

        <div style="text-decration:underline;display:inline">
        <a href="https://github.com/mbinary/USTC-CS-Courses-Resource.git" target="_blank" rel="external"><i class="fa fa-github"></i>&nbsp; Github</a>
        <a href="mailto:&#122;huheqin1@gmail?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fa fa-envelope"></i>&nbsp; Feedback</a>
        </div>

        <blockquote> <p> 如果出现了 404, 说明此博客与 github repo 更新不同步, 你可以尽快联系我解决, 或者访问 github </p></blockquote>
        {readme}
    </body>
</html>
'''

README=r'''
# 中国科学技术大学课程资源
>这是一个收集 中国科学技术大学课程资源的（主要是计算机学院的,也有其他课程,公选课,自由选修等）的 repo, 包括课程电子版 书籍，参考书，slides(ppt), 考试试卷，学习心得，某些书的答案。


# 目录
<!-- vim-markdown-toc GFM -->

* [公告](#公告)
* [资料下载](#资料下载)
* [贡献者们](#贡献者们)
* [课程结构](#课程结构)
* [课程目录](#课程目录)
* [管理投稿](#管理投稿)
    * [投稿方式](#投稿方式)
        * [帮忙上传](#帮忙上传)
        * [网页操作](#网页操作)
        * [用命令行](#用命令行)
    * [投稿建议](#投稿建议)
    * [管理工作](#管理工作)
* [版权声明](#版权声明)

<!-- vim-markdown-toc -->

# 公告
* 欢迎 star,fork. 欢迎反馈与建议（通过 [issue](issues/new),<a href="mailto:&#122;huheqin1@gmail.com?subject=%E5%8F%8D%E9%A6%88%E4%B8%8E%E5%BB%BA%E8%AE%AE">mail</a>, 或者 [qq](http://wpa.qq.com/msgrd?v=3&uin=414313516&site=qq&menu=yes))
* 可以通过在此页面搜索课程名快速定位,下面的课程目录是经过**拼音排序**过的,方便查找
* 可以添加其他计算机非课程资源, 欢迎大家的参与与贡献 (。・∀・)ノ

# 资料下载
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

## HTTPS
- github 网页
- [脚本生成的网页](https://mbinary.xyz/ustc-cs/)

脚本生成的网页中直接包含了下载链接, 比 github 方便一点. 而且在移动端下载二进制文件, 在github 需要点击两次(第一次显示`This file is binary and cannot be displayed inline`,需要再点`open binary file`/`Download`才行),后者只需要一次即可下载, 对于大的二进制文件, github 移动端的不能直接下载, 需要切换成 `Desktop Version` 才有 下载按钮.

FTP 更快, 可以下载整个目录, 是最好的选择, 只是更新频率低于网页

# [贡献者们](graphs/contributors)

# 课程结构
每门课程大致结构如下，有些栏目可能没有，也可以自己添加认为合理的栏目
* slides: 主要是 ppt 文件类型（若有多个老师，则在课程目录建立slides-teacherName1, slides-teacherName2...）
* homework & lab（一个或两个目录）
* 教材与参考书可以直接放在课程目录下
* 课程主页及其他链接资源（记在 课程/README.md 中)
* 心得与经验
* students（同学们上传的自己的一些资料,作品，每个同学新建一个目录)
* 非zip, 非以'.'开头的文件多于 3 个的目录下都有个 zip 文件：`-DIRECTORY 目录下的\d+个文件.zip`,包含当前目录下的一些文件, 这样方便大家一键下载. (在 git commit前, 运行 `./before__commit.sh`可以自动生成)

如`数据结构`课程

```
├ lab
│   ├ bankSimulation
│   ├ huffman
│   ├ navigation
│   ├ polynomial
│   └ README.md
├ slides
│   ├ ch10-排序.ppt
│   ├ ch1-绪论.ppt
│   ├ ch2-线性表.ppt
│   ├ ch3.ppt
│   ├ ch6.pps
│   ├ ch7.pps
│   ├ ch9.pps
│   ├ 数据结构c语言版严蔚敏PPT.ppt
│   └ -计算机与信息类-数据结构-slides目录下的8个文件.zip
├ students
│   ├ mbinary
│   └ README.md
├ 数据结构c_严蔚敏.pdf
└ 数据结构习题集答案(C语言版严蔚敏)_ca332.pdf
```


# 课程目录
**根据拼音字母排序**

{index}

# 管理投稿
欢迎大家的参与与贡献

## 投稿方式

### 帮忙上传
可以发给我或者其他同学帮忙上传, 或者提 issue

### 网页操作
* 用网页或者[桌面版](https://desktop.github.com/)直接操作，fork and pull request, 
   操作方式可以参考 [这里](https://blog.csdn.net/qq_29277155/article/details/51048990)和[这里](https://blog.csdn.net/zhangw0_0/article/details/50667891) ,[介绍pr操作](https://blog.csdn.net/huutu/article/details/51018317)

### 用命令行
对于用命令行的同学,提醒一下这个仓库很大（2018-5-2时已有 3G左右）
所以如果直接 clone 很慢。
可以使用 sparse-checkout, 只下载你指定的目录

首先用网页操作，创建你想要的目录（已有的可以直接用）, 如在公选课目录下创建`人工智障`,
然后在 cli 执行
```shell
mkdir ustc-courses  #文件夹名可以自己取
cd ustc-courses
git init
git remote add -f origin  git@github.com:mbinary/USTC-CS-Courses-Resource.git
git config core.sparsecheckout true
echo "公选课/人工智障"  >> .git/info/sparse-checkout  #这里工作目录就是在那个 repo 主页下

#如果还有其他目录，都像上面一样加入即可，如 `echo  "大二上/ICS/ppt" >> .git/info/sparse-checkout`
#只需记住的是 加入的目录应该在远程仓库存在，否则报错“error: Sparse checkout leaves no entry on the working directory”

git pull origin master
git remote add upstream git@github.com:mbinary/USTC-CS-Courses-Resource.git
```
建议: 如果没有较大的改动, 或者在改动之前,可以删除掉以前 fork 的仓库 重新 fork

更新内容后
```shell
git fetch upstream/master
git merge upstream/master
```

## 投稿建议
* github 上不能直接上传大于 100mb 的文件. 对于超过 100 mb 的文件, 可以存在云盘，然后将链接写在[这里](网盘资源/README.md)
* 若是自己原创的作品，可以在文件名后加上后缀，如`-16- 计 - 王小二`, 文件里也可以写上联系方式，当然不写也行。
* 注意资源大多是二进制文件, 多次改动会使 git 重新上传, 即使 `mv`, 也会使本地仓库重新上传到远程仓库,所以在没有必要的情况下, 不要对二进制文件做任何改动.



# 版权声明
所有资源，著作权归原作者所有，此 repo 的目的是**学习交流**.
如果使用者的不当使用造成不良后果，与此 repo 的贡献者无关。
'''

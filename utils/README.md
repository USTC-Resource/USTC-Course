# 一些用来管理课程资源的脚本
## genIndex.py
产生网页浏览目录, 索引, 通过os.walk 在每个目录下(过滤掉.开头的目录)产生index.html, 内容是当前目录下的文件夹列表与文件列表

## genZipFile.py
在每个目录下(过滤掉.开头的目录,下同)产生全部文件(文件数大于3)的zipfile,方便一键下载)

## checkBigFile.py
递归检查某个目录下的所有文件,如果大于100mb,就移动到 WALKDIR/.bigFile

## config.py
配置文件

## md_tree_link.py
遍历一个目录, 产生 markdown 格式的树状目录的链接

## pinyinSort.py
根据拼音字母 来排序

# coding: utf-8
import os
import markdown
import shutil

from mywalk import mywalk
from getSize import getSize
from config import PATH,HTML,WALKDIR,TARDIR,IGNORE

IndexFile = 'README.md' # index.html

hasPinyin = False
try:
    from pypinyin import pinyin
    hasPinyin = True
except:
    print('No module pypinyin, using defalut method to sort')

def pinyinSort(items):
    if hasPinyin:
        dic = {''.join(sum(pinyin(i,style=0),[])).lower():i for i in items}
        return [dic[i] for i in sorted(dic.keys())]
    else:
        print('No module pypinyin')
        return items

def md2html(s):
    exts = ['markdown.extensions.extra', 'markdown.extensions.codehilite','markdown.extensions.tables','markdown.extensions.toc']
    return markdown.markdown(s,extensions=exts)

def getFmt():
    dic={}
    sound_suf = ['file-sound-o',['mp3','wave','snd','aif','wav']]
    movie_suf =['file-movie-o', ['mp4','avi','mov','swf']]
    zip_suf = ['file-zip-o',['zip','rar','7z','tar','gz','bz','jar','z']]
    word_suf=['file-word-o',['doc','docx']]
    excel_suf=['file-excelo',['xls','xlt']]
    ppt_suf = ['file-powerpoint-o',['ppt','pptx','pps','pptx','ppa','ppam']]
    pdf_suf = ['file-pdf-o',['pdf']]
    pic_suf =['file-picture-o',['bmp','gif','png','jpg','jpeg','pic']]
    code_suf=['file-code-o',['c','o','h','sh','cc','m','cpp','py','lisp','scala','rust','java']]
    lst_suf=[sound_suf,movie_suf,zip_suf,word_suf,excel_suf,ppt_suf,pdf_suf,pic_suf,code_suf]

    for lst in lst_suf:
        suf, li = lst
        for i in li:
            dic[i]=suf
    dic['dir'] = 'folder'
    dic['other']='pencil-square-o'
    return dic

FMT_DIC = getFmt()

def getIcon(name):
    suf=name[name.rfind('.')+1:]
    return FMT_DIC[suf] if suf in FMT_DIC else FMT_DIC['other']

def valid(path):
    return not (path.startswith('.') or path in IGNORE)

def handleDir(target):
    if not  os.path.exists(TARDIR):
        os.mkdir(TARDIR)
    target = os.path.abspath(target)
    n = len(target)
    for path,dirs,files in mywalk(target,valid):
        dirs = pinyinSort(dirs)
        files = pinyinSort(files)
        path = path[n:].strip(os.path.sep)
        genIndex(path,dirs,files)

def genIndex(path,dirs,files,htmlTemp = HTML):
    md = ''
    if IndexFile in files:
        with open(os.path.join(path,IndexFile),'r',errors='ignore') as f :
            #<hr>\n<span style="color:orange;text-align:center;">Read  Me</span>\n<hr>\n
            md = '\n<h1 style="color:red;text-align:center;">Read Me</h1>\n'+f.read()
    cur = getPath(path)
    dirLst = genDirectoryList(path,dirs)
    fileLst = genFileList(path,files)
    cont = htmlTemp.format(cur=cur,dirLst = dirLst,fileLst = fileLst,readme=md2html(md))
    tar = os.path.join(TARDIR,path)
    if not os.path.exists(tar):os.mkdir(tar)
    filename = os.path.join(tar, IndexFile)
    with open(filename,'w') as f:
        f.write(cont)

def getPath(path):
    lst = path.split(os.path.sep)
    lst = lst[::-1]
    lst.append('<i class="fa fa-home"></i>')
    url = IndexFile
    res = []
    for i in lst:
        res.append('<a href="{url}">{txt}</a>'.format(url = url,txt = i))
        url='../'+url
    return '/'.join(res[::-1])

LIITEM = '<li><a href="{path}"><i class="fa fa-{icon}"></i>&nbsp;{name}</a></li>'
def genFileList(path,files):
    link= {i:os.path.join(path,i) for i in files}
    lst = [LIITEM.format(icon=getIcon(key),name = key+'---({})'.format(getSize(link[key])),path = os.path.join(PATH,link[key])) for key in files]
    if lst==[]: lst.append('<li><i class="fa fa-meh-o"></i>&nbsp;None</li>')
    return '\n'.join(lst)

def genDirectoryList(path,dirs):
    link = {i:os.path.join(i,IndexFile) for i in dirs}
    lst = [LIITEM.format(icon=FMT_DIC['dir'],name = key,path =link[key]) for key in dirs]
    if lst==[]: lst.append('<li><i class="fa fa-meh-o"></i>&nbsp;None</li>')
    return '\n'.join(lst)

if __name__ =='__main__':
    handleDir(WALKDIR)

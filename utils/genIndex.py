#coding: utf-8
import os
import re
from functools import partial
import markdown
import shutil
from getSize import getSize
from config import PATH, HTML, WALKDIR, TARDIR, IGNORE, NAME, DOWNLOAD

URL = 'https://github.com/USTC-Resource/USTC-Course/tree/master/'
ImagePT = re.compile(r'\!\[(.*?)\]\(([a-zA-Z\d\.].*?)\)')


def subFunc(match,pre):
    name, suf = match.groups()
    return f'![{name}]({pre+"/"+suf})'

hasPinyin = False
try:
    from pypinyin import pinyin
    hasPinyin = True
except:
    print('No module pypinyin, using defalut method to sort')


def pinyinSort(items):
    if hasPinyin:
        dic = {''.join(sum(pinyin(i, style=0), [])).lower(): i for i in items}
        return [dic[i] for i in sorted(dic.keys())]
    else:
        print('No module pypinyin')
        return items


def md2html(s):
    exts = [
        'markdown.extensions.extra', 'markdown.extensions.codehilite',
        'markdown.extensions.tables', 'markdown.extensions.toc'
    ]
    s = re.sub(r'\<\!--.*?--\>', '', s, flags=re.DOTALL)
    return markdown.markdown(s, extensions=exts)


def getFmt():
    dic = {
        'file-audio': ['mp3', 'wave', 'snd', 'aif', 'wav'],
        'file-video': ['mp4', 'avi', 'mov', 'swf'],
        'file-archive': ['zip', 'rar', '7z', 'tar', 'gz', 'bz', 'jar', 'z'],
        'file-word': ['doc', 'docx'],
        'file-excel': ['xls', 'xlt'],
        'file-powerpoint': ['ppt', 'pptx', 'pps', 'pptx', 'ppa', 'ppam'],
        'file-pdf': ['pdf'],
        'file-image': ['bmp', 'gif', 'png', 'jpg', 'jpeg', 'pic'],
        'file-code': [
            'c', 'o', 'h', 'sh', 'cc', 'm', 'cpp', 'py', 'lisp', 'scala',
            'rust', 'java'
        ],
        'file-import': ['md'],
    }
    FMT_DIC = {}
    for i, li in dic.items():
        for suf in li:
            FMT_DIC[suf] = i
    FMT_DIC['dir'] = 'folder'
    FMT_DIC['other'] = 'file'
    return FMT_DIC


FMT_DIC = getFmt()


def getIcon(name):
    suf = name[name.rfind('.') + 1:]
    return FMT_DIC[suf] if suf in FMT_DIC else FMT_DIC['other']


def prepare():
    if os.path.exists(TARDIR):
        os.system('rm -rf ' + TARDIR)
    try:
        os.mkdir(TARDIR)
        with open(
                os.path.join(TARDIR, '_config.yml'), 'w',
                encoding='utf-8') as f:
            f.write('theme: jekyll-theme-cayman\n')
    except:
        return


def handleDir(target):
    prepare()
    n = len(target)
    gen = os.walk(target)
    for path, dirs, files in gen:
        dirs = [d for d in dirs if d not in IGNORE]
        dirs = pinyinSort(dirs)
        files = pinyinSort(files)
        path = path[n:].strip(os.path.sep)
        segs = path.split(os.path.sep)
        if path.startswith('.') or any(seg in IGNORE for seg in segs): continue
        tar = os.path.join(TARDIR, path)
        if 'index.html' in files:
            try:
                shutil.copytree(path, tar)
            except Exception as e:
                print(e, path)
        else:
            genIndex(path, dirs, files)


def genIndex(path, dirs, files, htmlTemp=HTML):
    md = ''
    if 'README.md' in files:
        with open(os.path.join(path, 'README.md'), 'r', errors='ignore') as f:
            #<hr>\n<span style="color:orange;text-align:center;">Read  Me</span>\n<hr>\n
            md = '\n<h1 style="color:red;text-align:center;">Read Me</h1>\n' + f.read(
            )
            files.remove('README.md')
    cur = getPath(path)
    tar = os.path.join(TARDIR, path)
    if not os.path.exists(tar): os.mkdir(tar)

    dirLst = genDirectoryList(path, dirs)
    fileLst = genFileList(path, files, tar)
    cont = htmlTemp.format(
        DOWNLOAD=DOWNLOAD + path,
        cur=cur,
        dirLst=dirLst,
        fileLst=fileLst,
        readme=md2html(md))
    filename = os.path.join(tar, NAME)
    with open(filename, 'w') as f:
        f.write(re.sub(ImagePT,partial(subFunc,pre = URL+path),cont))


def getPath(path):
    lst = path.split(os.path.sep)
    lst = lst[::-1]
    lst.append('<i class="fas fa-home"></i>')
    url = 'index.html'
    res = []
    for i in lst:
        res.append('<a href="{url}">{txt}</a>'.format(url=url, txt=i))
        url = '../' + url
    return '/'.join(res[::-1])


LIITEM = '<li><a href="{path}"><i class="fas fa-{icon}"></i>&nbsp;{name}</a></li>'


def genFileList(path, files, tar=TARDIR):
    files = [i for i in files if not i.startswith('.')]
    link = {}
    for k in files:
        if k.endswith('.md'):
            shutil.copy(os.path.join(path, k), tar)
            link[k] = k[:-3] + '.html'
        else:
            link[k] = os.path.join(PATH, path, k)
    lst = [
        LIITEM.format(
            icon=getIcon(key),
            name=key + '---({})'.format(getSize(os.path.join(path, key))),
            path=link[key]) for key in files
    ]
    if lst == []: lst.append('<li><i class="fas fa-meh"></i>&nbsp;None</li>')
    return '\n'.join(lst)


def genDirectoryList(path, dirs):
    keys = [i for i in dirs if i[0] != '.']
    link = {i: os.path.join(i, 'index.html') for i in keys if i[0] != '.'}
    lst = [
        LIITEM.format(icon=FMT_DIC['dir'], name=key, path=link[key])
        for key in keys
    ]
    if lst == []: lst.append('<li><i class="fas fa-meh"></i>&nbsp;None</li>')
    return '\n'.join(lst)


if __name__ == '__main__':
    handleDir(WALKDIR)

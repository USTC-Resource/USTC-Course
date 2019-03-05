# coding: utf-8
import os
from pinyinSort import pinyinSort
from argparse import ArgumentParser

#命令行输入参数处理
parser = ArgumentParser()

parser.add_argument('-p','--path',default='.',help='path to walk')     
parser.add_argument('-f','--fileinclude',action='store_true',help='if has, list files and dirs, else only dirs')
parser.add_argument('-d','--depth', type = int, default = 2)
#获取参数
args = parser.parse_args()
FILE = args.fileinclude
PATH = args.path
DEPTH = args.depth

def mklink(path):
    return '* [{name}]({path})'.format(name=os.path.basename(path),path=path)
def clean(paths):
    ret = []
    for path in paths:
        name = os.path.basename(path)
        if not ( name.startswith('.') or name.startswith('__')):
            ret.append(path)
    return ret

def tree(path='.',depth=2,showfile=False):
    while not os.path.isdir(path):
        print('[error]: please input a directory, not file path')
        path = input()
    li = os.listdir(path)
    items = [os.path.join(path,i) for i in li if not i.startswith('.')]
    items = clean(items)
    items = pinyinSort(items)
    if not showfile: items = [i for i in items if os.path.isdir(i)]
    if depth==1:
        return [mklink(path)] + [' '*4 + mklink(i) for i in items]
    else:
        uls = [tree(i,depth-1,showfile) for i in items]
        ret = [' '*4 + li for ul in uls for li in ul]
        return  [mklink(path)] + ret

if __name__ =='__main__':
    print('\n'.join(tree(PATH,DEPTH,FILE)))

# coding: utf-8
import os
import shutil
from zipfile import ZipFile

from config import WALKDIR, IGNORE
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-r','--rewrite',help='rewrite zip file',action='store_true')
args = parser.parse_args()
REWRITE = args.rewrite

def checkZip(name):
    '''check if this file should be added to the zip'''
    li = [name.startswith('.') ,name.endswith('.zip'),name.lower()=='readme.md']
    return not any(li)

def isIgnore(li,files):
    return 'index.html' in files or any((i[0]=='.' and i!='.') or i.startswith('__') or i in IGNORE for i in li)
def genZipFile(tar = WALKDIR,rewrite=False):
    os.chdir(tar)
    n = len(tar)
    gen = os.walk(tar)
    pwd = os.path.abspath('.')
    for path, dirs, files in gen:
        li = path.strip(os.sep).split(os.sep)
        if isIgnore(li,files):continue
        ziplst = []
        for i in files:
            if i.endswith('个文件.zip'):
                if rewrite:
                    os.remove(os.path.join(path,i))
                else:break
            elif checkZip(i):
                ziplst .append(i)
        else:
            if len(ziplst)<3:continue
            ziplst.sort()
            tmp = os.path.abspath(path) \
                    .replace(pwd,'')\
                    .replace(os.sep,'-')
            name = '{tmp}目录下的{length}个文件.zip'.format(tmp=tmp,length =len(ziplst))
            zipName = os.path.join(path,name)
            try:
                with ZipFile(zipName,'w') as z:
                    os.chdir(path)
                    for i in ziplst: z.write(i)
            except Exception as e:
                print(e,path)

if __name__ == '__main__':
    genZipFile(rewrite=REWRITE)

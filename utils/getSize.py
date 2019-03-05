# coding: utf-8
import os
import sys
def formatSize(size):
    s = 'BKMGTP'
    ct = 0
    while size>=(1<<ct):
        ct+=10
    if ct>=10: ct-=10
    return '{sz:.2f}{a}'.format(sz=size/(1<<ct),a=s[ct//10])


def getSize(path='.'):
    if os.path.isdir(path):
        gen = os.walk(path)
        li  = []
        for root, dirs, files in gen:
            for f in files:
                sz = os.path.getsize(os.path.join(root ,f))
                li.append(sz)
        #li.insert(('.',sum(i[1] for i in li)),0)
        #size  = [f'{i[0]}: {formatSize(i[1])}' for i in li]
        return formatSize(sum(li))
    else:
        return formatSize(os.path.getsize(path))

if __name__ == "__main__":
    items = sys.argv[1:]
    for i in items:
        print('{i}: {sz}'.format(i=i,sz =getSize(i)))

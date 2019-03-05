import os
import shutil

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-p','--path',help='path to check',default='.')
parser.add_argument('-s','--size',help='max size of file to be removed',default=2**20*100) # 100Mb
args = parser.parse_args()

PATH = args.path
SIZE = args.size
def checkBigFile(path,size):
    big = '.bigFile'
    if not os.path.exists(big):
        os.mkdir(big)
    gen = os.walk(os.path.abspath(path))
    for path,dirs,files in gen:
        li = path.strip(os.sep).split(os.sep)
        if any([i[0]=='.' and i!='.' for i in li]):continue
        for file in files:
            filePath = os.path.join(path,file)
            sz = os.path.getsize(filePath)
            if sz > size:
                print('[BIG]: {} is bigger than 100mb'.format(filePath))
                try:
                    shutil.move(filePath,big)
                except Exception as e:
                    print(e,path)
                    os.remove(filePath)
if __name__=='__main__':
    checkBigFile(PATH,SIZE)

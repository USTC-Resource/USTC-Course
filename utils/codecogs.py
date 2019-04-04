import os
import re
import sys
from translate import Translator as TR

FORMULA = re.compile(r'\${1,2}(?P<formula>.+?)\${1,2}', re.DOTALL)
Chinese = re.compile(u"(?P<chinese>[\u4e00-\u9fa5]+)")
API = 'https://latex.codecogs.com/gif.latex?'


def codecog(f):
    if os.path.exists(f) and f.endswith('.md'):
        with open(f) as fp:
            txt = fp.read()
        with open(f, 'w') as fp:
            fp.write(re.sub(FORMULA, covert, txt))
    else:
        s = re.sub(FORMULA, covert, f)
        print(s)


def covert(matched):
    s = matched.group('formula').strip('$ ')
    s = re.sub(Chinese, zh2en, s)
    s = re.sub(r'\r+|\n+|\\n', ' ', s)
    s = re.sub(' +', '&space;', s)
    return '![]({})'.format(API + s)


def zh2en(txt):
    s = txt.group('chinese').strip()
    tran = TR(to_lang='en', from_lang='zh')
    en = tran.translate(s)
    return re.sub(' +', '-', en)


def handle(path):
    if os.path.isdir(path):
        for p, ds, fs in os.walk(path):
            for f in fs:
                if f.endswith('.md'):
                    codecog(os.path.join(p, f))
    else:
        codecog(path)


if __name__ == '__main__':
    args = sys.argv[1:]
    if not args:
        s = input('Input a file: ')
        args.append(s)
    for f in args:
        handle(f)

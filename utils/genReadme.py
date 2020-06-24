# coding: utf-8
from md_tree_links import tree
from argparse import ArgumentParser
from config import README, IGNORE

parser = ArgumentParser()

parser.add_argument('-p', '--path', default='.', help='path to walk')
parser.add_argument(
    '-f',
    '--fileinclude',
    action='store_true',
    help='if has, list files and dirs, else only dirs')
parser.add_argument('-d', '--depth', type=int, default=1)
# 获取参数
args = parser.parse_args()
FILE = args.fileinclude
PATH = args.path
DEPTH = args.depth

idxs = tree(PATH, DEPTH, FILE, IGNORE)
s = README.format(index='\n'.join(idxs))
with open('README.md', 'w') as f:
    f.write(s)

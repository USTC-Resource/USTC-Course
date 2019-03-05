import os

def mywalk(dire,valid=lambda x:True):
    if not os.path.isdir(dire):
        raise Exception('[Error]: directory excepted')
    dirs = []
    files = []
    for i in os.listdir(dire):
        i = os.path.join(dire,i)
        if valid(i):
            if os.path.isdir(i):
                dirs.append(i)
            else:
                files.append(i)
    yield dire,dirs,files
    for d in dirs:
        yield from mywalk(os.path.join(dire,d),valid)

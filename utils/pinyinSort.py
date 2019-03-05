# coding: utf-8
hasPinyin=False
try:
    from pypinyin import pinyin
    hasPinyin=True
except:
    print('No module pypinyin, using defalut method to sort')

def pinyinSort(items):
    if hasPinyin:
        dic = {''.join(sum(pinyin(i,style=0),[])).lower():i for i in items}
        return [dic[i] for i in sorted(dic.keys())]
    else:return items

if __name__ =='__main__':
    s='你是谁中国科学技术大学'
    li = list(s)
    print(li)
    for i in pinyinSort(li):
        print(i)

import sys
import cv2
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt

def trans(img, k, b):
    img2 = np.zeros(img.shape, dtype=img.dtype)

    n, m = img.shape
    for i in range(n):
        for j in range(m):
            img2[i][j] = round(img[i][j] * k + b) # auto adjust data type
    return img2

def scale(img, x1, y1, x2, y2):
    img2 = np.zeros(img.shape, dtype=img.dtype)

    n, m = img.shape
    for i in range(n):
        for j in range(m):
            x = img[i][j]
            if (x < x1):
                img2[i][j] = 0+y1 * x // x2 # add 0(int)  to adjust data type
            elif x <= x2:
                img2[i][j] = 0+(y2 - y1) * (x - x1) // (x2 - x1) + y1
            else:
                img2[i][j] = 0+(255 - y2) * (x - x2) // (255 - x2) + y2
    return img2

def histogram(img, high=200, low=20):
    img2 = np.zeros(img.shape, dtype=img.dtype)

    n, m = img.shape
    dic = {}
    for i in range(n):
        for j in range(m):
            x = img[i][j]
            if x in dic:
                dic[x] += 1
            else:
                dic[x] = 1

    tot = n*m
    keys = sorted(i for i in dic if low <= i <= high)
    values = [dic[k]/tot for k in keys]
    return keys,values

def histogram_equalize(img=cv2.imread('images/pout.bmp',cv2.IMREAD_GRAYSCALE)):
    n, m = img.shape
    dic = {}
    for i in range(n):
        for j in range(m):
            x = img[i][j]
            if x in dic:
                dic[x] += 1
            else:
                dic[x] = 1

    acc = 0
    mapping={}
    tot = n*m
    for k in sorted(dic.keys()):  # sort, important
        acc+=dic[k]
        mapping[k]=round(acc/tot*255)

    equalized = {}
    for k in dic:
        newK = mapping[k]
        if newK in equalized:
            equalized[newK]+=dic[k]
        else:
            equalized[newK]=dic[k]
    img2 = np.zeros(img.shape, dtype=img.dtype)
    for i in range(n):
        for j in range(m):
            img2[i][j] = mapping[img[i][j]]
    return img2, equalized.keys(),[equalized[k]/tot for k in equalized]

def show(img, s='opencv'):
    print(s)
    cv2.namedWindow(s)
    cv2.resizeWindow(s, 1000, 1000)
    cv2.imshow(s, img)
    key = cv2.waitKey(5000)
    cv2.destroyAllWindows()


if __name__ == '__main__':
    path = sys.argv[1]
    img = cv2.imread(path, cv2.IMREAD_GRAYSCALE)

    k, b = 0.8, 10
    img2 = trans(img, k, b)

    x1, y1, x2, y2 = 5,5,200,150
    img3 = scale(img, x1, y1, x2, y2)

    high,low = 200,20
    keys,values = histogram(img,high,low)

    img4, keys2,values2 = histogram_equalize(img)

    cmap = mpl.cm.gray # mpl.cm.gray_r   'gray'

    plt.figure(figsize=(10, 10))

    plt.subplot(321), plt.imshow(img,cmap=cmap), plt.title('origin'),plt.xticks([]), plt.yticks([])
    plt.subplot(322), plt.imshow(img2,cmap=cmap), plt.title(f'tran k={k},b={b}'),plt.xticks([]), plt.yticks([])
    plt.subplot(323), plt.imshow(img3,cmap=cmap), plt.title(f'scaling  (x1,y1,x2,y2)=({(x1,y1,x2,y2)}'),plt.xticks([]), plt.yticks([])
    plt.subplot(324), plt.imshow(img4,cmap=cmap), plt.title(f'equalized'),plt.xticks([]), plt.yticks([])
    plt.subplot(325),plt.xlim([0,256]),  plt.bar(keys,values), plt.title(f'pdf')
    plt.subplot(326),plt.xlim([0,256]),  plt.bar(keys2,values2), plt.title(f'equalized pdf')

    plt.show()

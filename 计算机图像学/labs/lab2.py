import sys
from random import random
from collections import Iterable

import cv2
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt


def noise(img, rate=0.03):
    '''3% 的椒盐噪音'''
    img2 = np.zeros(img.shape, img.dtype)
    n, m = img.shape
    mn = 255
    mx = 0
    for i in range(n):
        for j in range(m):
            if img[i][j] < mn:
                mn = img[i][j]
            if img[i][j] > mx:
                mx = img[i][j]
    for i in range(n):
        for j in range(m):
            if random() <= rate:
                if random() <= 0.5:
                    img2[i][j] = mn
                else:
                    img2[i][j] = mx
            else:
                img2[i][j] = img[i][j]
    return img2


def mean_filter(img, window_size=3):
    def mysum(obj):
        if isinstance(obj, Iterable):
            return sum((mysum(i) for i in obj),
                       0)  # intital int 0, convert uint8 to int
        return obj

    if window_size % 2 == 0:
        window_size += 1

    n, m = img.shape
    if n < 2 * window_size or m < 2 * window_size:
        raise Exception("[Error]: filter window is too large!")

    img2 = np.zeros(img.shape, img.dtype)

    half = window_size // 2
    tot = window_size * window_size

    n2 = n - half
    m2 = m - half
    sm = 0
    for i in range(n):
        for j in range(m):
            if i < half or j < half or i >= n2 or j >= m2:
                img2[i][j] = img[i][j]

            else:
                if j == half:
                    sm = mysum(img[i - half:i + half + 1, :window_size])
                else:
                    sm += mysum(img[i - half:i + half + 1, j + half]) - mysum(
                        img[i - half:i + half + 1, j - half - 1])
                img2[i][j] = (sm + tot - 1) // tot

    return img2


def median_filter(img, window_size=3):
    def find_median(arr):
        i, j = 0, len(arr) - 1
        mid = len(arr) // 2
        while 1:
            p = i
            pivot = arr[p]
            while i < j:
                while i < j and arr[j] >= pivot:
                    j -= 1
                if i < j:
                    arr[i] = arr[j]
                    i += 1
                while i < j and arr[i] <= pivot:
                    i += 1
                if i < j:
                    arr[j] = arr[i]
                    j -= 1
            arr[i] = pivot
            if i < mid:
                i += 1
                j = len(arr) - 1
            elif j > mid:
                i = 0
                j -= 1
            else:
                return pivot

    if window_size % 2 == 0:
        window_size += 1

    n, m = img.shape
    if n < 2 * window_size or m < 2 * window_size:
        raise Exception("[Error]: filter window is too large!")

    img2 = np.zeros(img.shape, img.dtype)

    half = window_size // 2

    n2 = n - half
    m2 = m - half

    beg1 = end1 = beg2 = end2 = 0
    for i in range(n):
        for j in range(m):
            if i < half or j < half or i >= n2 or j >= m2:
                img2[i][j] = img[i][j]

            else:
                if j == half:
                    # add  by columns
                    beg1 = i - half
                    end1 = i + half + 1
                    beg2 = 0
                    end2 = window_size
                else:
                    beg2 += 1
                    end2 += 1
                window = list(img[beg1:end1, beg2:end2].flat)
                img2[i][j] = find_median(window)
    return img2


if __name__ == '__main__':
    path = sys.argv[1]
    img = cv2.imread(path, cv2.IMREAD_GRAYSCALE)
    noised_img = noise(img)

    img2 = mean_filter(noised_img)
    img3 = median_filter(noised_img)

    cmap = mpl.cm.gray
    plt.figure(figsize=(8, 8))

    plt.subplot(221), plt.xticks([]), plt.yticks([])
    plt.imshow(img, cmap=cmap)
    plt.title('origin')

    plt.subplot(222), plt.xticks([]), plt.yticks([])
    plt.imshow(noised_img, cmap=cmap)
    plt.title('noised')

    plt.subplot(223), plt.xticks([]), plt.yticks([])
    plt.imshow(img2, cmap=cmap)
    plt.title('mean_filter')

    plt.subplot(224), plt.xticks([]), plt.yticks([])
    plt.imshow(img3, cmap=cmap)
    plt.title('median_filter')

    plt.show()

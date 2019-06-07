import sys

import cv2
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt


def roberts(img):
    n, m = img.shape
    img2 = np.zeros(img.shape, img.dtype)
    for i in range(n):
        for j in range(m):
            if i == n - 1 or j == m - 1:
                img2[i][j] = img[i][j]
            else:
                # add 0 to convert uint8 to int, avoiding overflow
                img2[i][j] = abs(0 + img[i][j] - img[i + 1][j + 1]) + abs(
                    0 + img[i + 1][j] - img[i][j + 1])
    return img2


def prewitt(img):
    n, m = img.shape
    img2 = np.zeros(img.shape, img.dtype)
    for i in range(n):
        for j in range(m):
            if i < 1 or j < 1 or i == n - 1 or j == m - 1:
                img2[i][j] = img[i][j]
            else:
                # add 0 to convert uint8 to int, avoiding overflow
                dx = abs(0 + img[i - 1][j - 1] + img[i - 1][j] +
                         img[i - 1][j + 1] - img[i + 1][j - 1] -
                         img[i + 1][j] - img[i + 1][j + 1])
                dy = abs(0 + img[i - 1][j - 1] + img[i][j - 1] +
                         img[i + 1][j - 1] - img[i - 1][j + 1] -
                         img[i][j + 1] - img[i + 1][j + 1])
                img2[i][j] = (dx * dx + dy * dy)**0.5
    return img2


if __name__ == '__main__':
    path = sys.argv[1]
    img = cv2.imread(path, cv2.IMREAD_GRAYSCALE)

    img2 = roberts(img)
    img3 = prewitt(img)
    cmap = mpl.cm.gray
    plt.figure(figsize=(10, 10))

    plt.subplot(221),plt.xticks([]), plt.yticks([])
    plt.imshow(img, cmap=cmap)
    plt.title('origin')

    plt.subplot(223),plt.xticks([]), plt.yticks([])
    plt.imshow(img2, cmap=cmap)
    plt.title('roberts')

    plt.subplot(224),plt.xticks([]), plt.yticks([])
    plt.imshow(img3, cmap=cmap)
    plt.title('prewitt')

    plt.show()

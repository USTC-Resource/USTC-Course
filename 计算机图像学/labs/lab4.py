import sys

import cv2
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt


def fft(img):
    f = np.fft.fft2(img)
    # fshift = np.fft.fftshift(f)
    # magnitude_spectrum
    mag = np.abs(f)
    imag = np.fft.ifft2(mag)
    phase = np.angle(f)
    iphase = np.fft.ifft2(phase)
    return mag, phase, imag, iphase


if __name__ == '__main__':
    path = sys.argv[1]
    img = cv2.imread(path, cv2.IMREAD_GRAYSCALE)

    mag, phase, imag, iphase = fft(img)
    mag = np.log(mag + 1)
    imag = np.real(imag)
    iphase = np.real(iphase)

    cmap = mpl.cm.gray
    plt.figure(figsize=(10, 10))

    plt.subplot(221), plt.imshow(img, cmap=cmap)
    plt.title('Input Image'), plt.xticks([]), plt.yticks([])
    plt.subplot(222), plt.imshow(mag, cmap=cmap)
    plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
    plt.subplot(223), plt.imshow(imag, cmap=cmap)
    plt.title('idft [ magnitude] '), plt.xticks([]), plt.yticks([])
    plt.subplot(224), plt.imshow(iphase, cmap=cmap)
    plt.title('idft [ phase ]'), plt.xticks([]), plt.yticks([])
    plt.show()

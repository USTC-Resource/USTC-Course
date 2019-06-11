import sys

import cv2
import numpy as np
import matplotlib as mpl
from matplotlib import pyplot as plt
import dft




if __name__ == '__main__':
    path = sys.argv[1]
    img = cv2.imread(path, cv2.IMREAD_GRAYSCALE)

    f = dft.fft2(img)
    # magnitude_spectrum
    mag = np.abs(f)
    invert_magnitude = dft.ifft2(mag)
    mag = np.log(mag + 1)
    phase = np.angle(f)
    iphase = dft.ifft2(phase)
    invert_magnitude = np.real(invert_magnitude)
    iphase = np.real(iphase)

    cmap = mpl.cm.gray
    plt.figure(figsize=(6,6))

    plt.subplot(221), plt.imshow(img, cmap=cmap)
    plt.title('Input Image'), plt.xticks([]), plt.yticks([])
    plt.subplot(222), plt.imshow(mag, cmap=cmap)
    plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
    plt.subplot(223), plt.imshow(invert_magnitude, cmap=cmap)
    plt.title('idft [ magnitude] '), plt.xticks([]), plt.yticks([])
    plt.subplot(224), plt.imshow(iphase, cmap=cmap)
    plt.title('idft [ phase ]'), plt.xticks([]), plt.yticks([])
    plt.show()

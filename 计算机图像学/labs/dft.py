''' mbinary
#########################################################################
# File : fft.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2019-06-11  12:48
# Description:
#########################################################################
'''
import numpy as np


def _fft_n2(a, invert):
    '''O(n^2)'''
    N = len(a)
    w = np.arange(N)
    i = 2j if invert else -2j
    m = w.reshape((N, 1)) * w
    W = np.exp(m * i * np.pi / N)
    return np.concatenate(np.dot(W, a.reshape((N,
                                               1))))  # important, cannot use *


def _fft(a, invert=False):
    '''recursion version'''
    N = len(a)
    if N == 1:
        return [a[0]]
    elif N & (N - 1) == 0:  # O(nlogn),  2^k
        even = _fft(a[::2], invert)
        odd = _fft(a[1::2], invert)
        i = 2j if invert else -2j
        factor = np.exp(i * np.pi * np.arange(N // 2) / N)
        prod = factor * odd
        return np.concatenate([even + prod, even - prod])
    else:
        return _fft_n2(a, invert)


def _fft2(a, invert=False):
    ''' iteration version'''

    def rev(x):
        ret = 0
        for i in range(r):
            ret <<= 1
            if x & 1:
                ret += 1
            x >>= 1
        return ret

    N = len(a)
    if N & (N - 1) == 0:  # O(nlogn),  2^k
        r = int(np.log(N))
        c = np.array(a,dtype='complex')
        i = 2j if invert else -2j
        w = np.exp(i * np.pi / N)
        for h in range(r - 1, -1, -1):
            p = 2**h
            z = w**(N / p / 2)
            for k in range(N):
                if k % p == k % (2 * p):
                    c[k], c[k + p] = c[k] + c[k + p], c[k] * z**(k % p)

        return np.asarray([c[rev(i)] for i in range(N)])
    else:  # O(n^2)
        return _fft_n2(a, invert)


def fft(a):
    '''fourier[a]'''
    n = len(a)
    if n == 0:
        raise Exception("[Error]: Invalid length: 0")
    return _fft(a)


def ifft(a):
    '''invert fourier[a]'''
    n = len(a)
    if n == 0:
        raise Exception("[Error]: Invalid length: 0")
    return _fft(a, True) / n


def fft2(arr):
    return np.apply_along_axis(fft, 0,
                               np.apply_along_axis(fft, 1, np.asarray(arr)))


def ifft2(arr):
    return np.apply_along_axis(ifft, 0,
                               np.apply_along_axis(ifft, 1, np.asarray(arr)))


def test(n=128):
    print('\nsequence length:', n)
    print('fft')
    li = np.random.random(n)
    print(np.allclose(fft(li), np.fft.fft(li)))

    print('ifft')
    li = np.random.random(n)
    print(np.allclose(ifft(li), np.fft.ifft(li)))

    print('fft2')
    li = np.random.random(n * n).reshape((n, n))
    print(np.allclose(fft2(li), np.fft.fft2(li)))

    print('ifft2')
    li = np.random.random(n * n).reshape((n, n))
    print(np.allclose(ifft2(li), np.fft.ifft2(li)))


if __name__ == '__main__':
    for i in range(1, 4):
        test(i * 16)

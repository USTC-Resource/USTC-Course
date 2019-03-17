---
title: Number-Theory
date: 2018-12-16  16:56
categories: 数据结构与算法
tags: [数学,数论]
keywords:  
mathjax: true
description: "bezouts-identity, primality_test, miller-rabin, prime-sieve, pollards-rho-algorithm, modulo equation"
---

<!-- TOC -->

- [0.1. gcd, co-primes](#01-gcd-co-primes)
    - [0.1.1. Bezout's identity](#011-bezouts-identity)
- [0.2. primality_test](#02-primality_test)
    - [0.2.1. Prime Sieve](#021-prime-sieve)
    - [0.2.2. Miller-Rabin](#022-miller-rabin)
- [0.3. Factorization](#03-factorization)
    - [0.3.1. Pollard's rho algorithm](#031-pollards-rho-algorithm)
- [0.4. Euler function](#04-euler-function)
- [0.5. Modulo equation](#05-modulo-equation)

<!-- /TOC -->

<a id="markdown-01-gcd-co-primes" name="01-gcd-co-primes"></a>
## 0.1. gcd, co-primes
`gcd` is  short for  `greatest common divisor`
If `a`,`b` are  co-primes, we denote as ![](https://latex.codecogs.com/gif.latex?(a,b)=1,&space;\text{which&space;means&space;}&space;gcd(a,b)=1)
We can use `Euclid algorithm` to calculate `gcd` of two numbers.
```python
def gcd(a,b):
    while b!=0:
        a,b=b,a%b
    return a
```

<a id="markdown-011-bezouts-identity" name="011-bezouts-identity"></a>
### 0.1.1. Bezout's identity
 Let *a* and *b* be [integers](https://en.wikipedia.org/wiki/Integer "Integer") with [greatest common divisor](https://en.wikipedia.org/wiki/Greatest_common_divisor "Greatest common divisor") *d*. Then, there exist integers *x* and *y* such that *ax* + *by* = *d*. More generally, the integers of the form *ax* + *by* are exactly the multiples of *d*.

we can use extended euclid algorithm to calculate x,y,gcd(a,b)
```python gcd.py
def xgcd(a,b):
    '''return gcd(a,b),  x,y  where  ax+by=gcd(a,b)'''
    if b==0:return a,1,0
    g,x,y = xgcd(b,a%b)
    return g,y,x-a//b*y
```


<a id="markdown-02-primality_test" name="02-primality_test"></a>
## 0.2. primality_test
<a id="markdown-021-prime-sieve" name="021-prime-sieve"></a>
### 0.2.1. Prime Sieve
```python
class primeSieve:
    '''sieve of Eratosthenes, It will be more efficient when judging many times'''
    primes = [2,3,5,7,11,13]
    def isPrime(self,x):
        if x<=primes[-1]:
            return twoDivideFind(x,self.primes)
        while x>self.primes[-1]:
            left = self.primes[-1]
            right = (left+1)**2
            lst = []
            for i in range(left,right):
                for j in self.primes:
                    if i%j==0:break
                else:lst.append(i)
            self.primes+=lst
        return twoDivideFind(x,lst)

def twoDivideFind(x,li):
    a,b = 0, len(li)
    while a<=b:
        mid = (a+b)//2
        if li[mid]<x:a=mid+1
        elif li[mid]>x: b= mid-1
        else:return mid
    return -1
```
<a id="markdown-022-miller-rabin" name="022-miller-rabin"></a>
### 0.2.2. Miller-Rabin
>Excerpted from [wikipedia:Miller_Rabin_primality_test](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test)


Just like the Fermat and Solovay–Strassen tests, the Miller–Rabin test relies on an equality or set of equalities that hold true for prime values, then checks whether or not they hold for a number that we want to test for primality.

First, a [lemma](https://en.wikipedia.org/wiki/Lemma_(mathematics) "Lemma (mathematics)") about square [roots of unity](https://en.wikipedia.org/wiki/Root_of_unity "Root of unity") in the [finite field](https://en.wikipedia.org/wiki/Finite_field "Finite field") **Z**/*p***Z**, where *p* is prime and *p* > 2\. Certainly 1 and −1 always yield 1 when squared modulo *p*; call these [trivial](https://en.wikipedia.org/wiki/Trivial_(mathematics) "Trivial (mathematics)") [square roots](https://en.wikipedia.org/wiki/Square_root "Square root") of 1\. There are no *nontrivial* square roots of 1 modulo *p* (a special case of the result that, in a field, a [polynomial](https://en.wikipedia.org/wiki/Polynomial "Polynomial") has no more zeroes than its degree). To show this, suppose that *x* is a square root of 1 modulo *p*. Then:
![](https://latex.codecogs.com/gif.latex?x^2\equiv1\&space;(mod\&space;p))
![](https://latex.codecogs.com/gif.latex?(x-1)(x+1)&space;\equiv&space;0\&space;(mod\&space;p))



In other words, prime *p* divides the product (*x* − 1)(*x* + 1). By [Euclid's lemma](https://en.wikipedia.org/wiki/Euclid%27s_lemma "Euclid's lemma") it divides one of the factors *x* − 1 or *x* + 1, implying that *x* is congruent to either 1 or −1 modulo *p*.

Now, let *n* be prime, and odd, with *n* > 2\. It follows that *n* − 1 is even and we can write it as 2<sup>*s*</sup>·*d*, where *s* and *d* are positive integers and *d* is odd. For each *a* in (**Z**/*n***Z**)*, either

![](https://latex.codecogs.com/gif.latex?a^d\equiv&space;1\&space;(mod\&space;n))
or
![](https://latex.codecogs.com/gif.latex?a^{2^r*d}\equiv&space;-1\&space;(mod\&space;n),&space;\text{where&space;}&space;0\le&space;r<s)



To show that one of these must be true, recall [Fermat's little theorem](https://en.wikipedia.org/wiki/Fermat%27s_little_theorem "Fermat's little theorem"), that for a prime number n:
![](https://latex.codecogs.com/gif.latex?a^{n-1}\equiv1\&space;(mod\&space;n))

By the lemma above, if we keep taking square roots of *a*<sup>*n*−1</sup>, we will get either 1 or −1\. If we get −1 then the second equality holds and it is done. If we never get −1, then when we have taken out every power of 2, we are left with the first equality.

The Miller–Rabin primality test is based on the [contrapositive](https://en.wikipedia.org/wiki/Contrapositive "Contrapositive") of the above claim. That is, if we can find an *a* such that
![](https://latex.codecogs.com/gif.latex?a^d&space;ot\equiv&space;1\&space;(mod\&space;n))
and

![](https://latex.codecogs.com/gif.latex?a^{2^r*d}&space;ot\equiv&space;-1\&space;(mod\&space;n),&space;\text{where&space;}&space;0\le&space;r<s)

 then *n* is not prime. We call *a* a [witness](https://en.wikipedia.org/wiki/Witness_(mathematics) "Witness (mathematics)") for the compositeness of *n* (sometimes misleadingly called a *strong witness*, although it is a certain proof of this fact). Otherwise *a* is called a *strong liar*, and *n* is a [strong probable prime](https://en.wikipedia.org/wiki/Probable_prime "Probable prime") to base *a*. The term "strong liar" refers to the case where *n* is composite but nevertheless the equations hold as they would for a prime.

Every odd composite *n* has many witnesses *a*, however, no simple way of generating such an *a* is known. The solution is to make the test [probabilistic](https://en.wikipedia.org/wiki/Primality_test#Probabilistic_tests "Primality test"): we choose a non-zero *a* in **Z**/*n***Z** randomly, and check whether or not it is a witness for the compositeness of *n*. If *n* is composite, most of the choices for *a* will be witnesses, and the test will detect *n* as composite with high probability. There is, nevertheless, a small chance that we are unlucky and hit an *a* which is a strong liar for *n*. We may reduce the probability of such error by repeating the test for several independently chosen *a*.

For testing large numbers, it is common to choose random bases *a*, as, a priori, we don't know the distribution of witnesses and liars among the numbers 1, 2, ..., *n* − 1\. In particular, Arnault <sup>[[4]](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test#cite_note-Arnault397Digit-4)</sup> gave a 397-digit composite number for which all bases *a*less than 307 are strong liars. As expected this number was reported to be prime by the [Maple](https://en.wikipedia.org/wiki/Maple_(software) "Maple (software)") `isprime()` function, which implemented the Miller–Rabin test by checking the specific bases 2,3,5,7, and 11\. However, selection of a few specific small bases can guarantee identification of composites for *n* less than some maximum determined by said bases. This maximum is generally quite large compared to the bases. As random bases lack such determinism for small *n*, specific bases are better in some circumstances.

![](https://upload-images.jianshu.io/upload_images/7130568-7f3df40f4058182c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

python implementation
```python
from random import sample
def quickMulMod(a,b,m):
    '''a*b%m,  quick'''
    ret = 0
    while b:
        if b&1:
            ret = (a+ret)%m
        b//=2
        a = (a+a)%m
    return ret

def quickPowMod(a,b,m):
    '''a^b %m, quick,  O(logn)'''
    ret =1
    while b:
        if b&1:
            ret =quickMulMod(ret,a,m)
        b//=2
        a = quickMulMod(a,a,m)
    return ret


def isPrime(n,t=5):
    '''miller rabin primality test,  a probability result
        t is the number of iteration(witness)
    '''
    if n<2:
        print('[Error]: {} can\'t be classed with prime or composite'.format(n))
        return
    if n==2: return True
    d = n-1
    r = 0
    while d%2==0:
        r+=1
        d//=2
    t = min(n-3,t)
    for a in sample(range(2,n-1),t):
        x= quickPowMod(a,d,n)
        if x==1 or x==n-1: continue  #success,
        for j in range(r-1):
            x= quickMulMod(x,x,n)
            if x==n-1:break
        else:
            return False
    return True
```

<a id="markdown-03-factorization" name="03-factorization"></a>
## 0.3. Factorization
<a id="markdown-031-pollards-rho-algorithm" name="031-pollards-rho-algorithm"></a>
### 0.3.1. Pollard's rho algorithm

>Excerpted from [wikipedia:Pollard's rho algorithm](https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm)


Suppose we need to factorize a number 
![](https://latex.codecogs.com/gif.latex?n=pq), where ![](https://latex.codecogs.com/gif.latex?p) is a non-trivial factor. A polynomial modulo ![](https://latex.codecogs.com/gif.latex?n), called
![](https://latex.codecogs.com/gif.latex?g(x)=x^2+c\&space;mod\&space;n)
where c is a chosen number ,eg 1.

is used to generate a [pseudo-random sequence](https://en.wikipedia.org/wiki/Pseudo-random_sequence "Pseudo-random sequence"): A starting value, say 2, is chosen, and the sequence continues as  
![](https://latex.codecogs.com/gif.latex?x_1&space;=&space;g(2),x_2=g(g(2)),\ldots,&space;x_i&space;=g^{(i)}(2)&space;=&space;g(x_{i-1}))
, 
The sequence is related to another sequence![](https://latex.codecogs.com/gif.latex?\{x_k\&space;mod&space;\&space;p\}) . Since ![](https://latex.codecogs.com/gif.latex?p) is not known beforehand, this sequence cannot be explicitly computed in the algorithm. Yet, in it lies the core idea of the algorithm.

Because the number of possible values for these sequences are finite, both the![](https://latex.codecogs.com/gif.latex?\{x_n\}) sequence, which is mod ![](https://latex.codecogs.com/gif.latex?n) , and ![](https://latex.codecogs.com/gif.latex?\{x_n\&space;mod\&space;p\}) sequence will eventually repeat, even though we do not know the latter. Assume that the sequences behave like random numbers. Due to the [birthday paradox](https://en.wikipedia.org/wiki/Birthday_paradox "Birthday paradox"), the number of![](https://latex.codecogs.com/gif.latex?x_k)before a repetition occurs is expected to be ![](https://latex.codecogs.com/gif.latex?O(\sqrt{N})) , where ![](https://latex.codecogs.com/gif.latex?N)  is the number of possible values. So the sequence  ![](https://latex.codecogs.com/gif.latex?\{x_n\&space;mod\&space;p\})  will likely repeat much earlier than the sequence ![](https://latex.codecogs.com/gif.latex?x_k). Once a sequence has a repeated value, the sequence will cycle, because each value depends only on the one before it. This structure of eventual cycling gives rise to the name "Rho algorithm", owing to similarity to the shape of the Greek character ρ when the values  ![](https://latex.codecogs.com/gif.latex?x_i\&space;mod&space;\&space;p)  are represented as nodes in a [directed graph](https://en.wikipedia.org/wiki/Directed_graph "Directed graph").

![](https://upload-images.jianshu.io/upload_images/7130568-c336ac454ecd619c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
This is detected by the [Floyd's cycle-finding algorithm](https://en.wikipedia.org/wiki/Floyd%27s_cycle-finding_algorithm "Floyd's cycle-finding algorithm"): two nodes![](https://latex.codecogs.com/gif.latex?i,j) are kept. In each step, one moves to the next node in the sequence and the other moves to the one after the next node. After that, it is checked whether ![](https://latex.codecogs.com/gif.latex?\text{gcd}(x_i-x_j,n)&space;eq&space;1).
If it is not 1, then this implies that there ris a repetition in the ![](https://latex.codecogs.com/gif.latex?\{x_k\&space;mod\&space;p\}) swquence

This works because if the ![](https://latex.codecogs.com/gif.latex?x_i\&space;mod\&space;p)is the same as![](https://latex.codecogs.com/gif.latex?x_j\&space;mod\&space;p), the difference between![](https://latex.codecogs.com/gif.latex?x_i,x_j) is necessarily a multiple of ![](https://latex.codecogs.com/gif.latex?p). Although this always happens eventually, the resulting GCD is a divisor of ![](https://latex.codecogs.com/gif.latex?n) other than 1\. This may be![](https://latex.codecogs.com/gif.latex?n) itself, since the two sequences might repeat at the same time. In this (uncommon) case the algorithm fails, and can be repeated with a different parameter.

![](https://upload-images.jianshu.io/upload_images/7130568-7c3be944a0cd04df.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

python implementation
```python
from random import randint
from isPrime import isPrime
from gcd import gcd

def factor(n):
    '''pollard's rho algorithm'''
    if n==1: return []
    if isPrime(n):return [n]
    fact=1
    cycle_size=2
    x = x_fixed = 2
    c = randint(1,n)
    while fact==1:
        for i in range(cycle_size):
            if fact>1:break
            x=(x*x+c)%n
            if x==x_fixed:
                c = randint(1,n)
                continue
            fact = gcd(x-x_fixed,n)
        cycle_size *=2
        x_fixed = x
    return factor(fact)+factor(n//fact)
```

<a id="markdown-04-euler-function" name="04-euler-function"></a>
## 0.4. Euler function
Euler function, denoted as ![](https://latex.codecogs.com/gif.latex?\phi(n)), mapping  n as the number of number which is smaller than n and is the co-prime of n.

e.g.: ![](https://latex.codecogs.com/gif.latex?\phi(3)=2) since 1,2 are coprimes of 3 and smaller than 3,   ![](https://latex.codecogs.com/gif.latex?\phi(4)=2) ,(1,3)

Euler function is a kind of productive function and has two properties as follows:
1. ![](https://latex.codecogs.com/gif.latex?\phi(p^k)&space;=&space;p^k-p^{k-1}), where p is a prime
2. ![](https://latex.codecogs.com/gif.latex?\phi(mn)&space;=&space;\phi(m)*\phi(n)) where ![](https://latex.codecogs.com/gif.latex?(m,n)=1)

Thus, for every narural number *n*, we can evaluate ![](https://latex.codecogs.com/gif.latex?\phi(n)) using the following method.
1. factorize n:  
![](https://latex.codecogs.com/gif.latex?n&space;=&space;\prod&space;_{i=1}^{l}&space;p_i^{k_i}), where ![](https://latex.codecogs.com/gif.latex?p_i) is a prime and ![](https://latex.codecogs.com/gif.latex?k_i,l&space;>&space;0) .
2. calculate ![](https://latex.codecogs.com/gif.latex?\phi(n)) using the two properties.

![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;\phi(n)&space;&=\phi(&space;\prod&space;_{i=1}^{l}&space;p_i^{k_i})&space;\\&space;&=\prod&space;_{i=1}^{l}&space;\phi(&space;p_i^{k_i})&space;\\&space;&=\prod&space;_{i=1}^{l}&space;(&space;p_i^{k_i}-p_i^{&space;{k_i}-1})\\&space;&=\prod&space;_{i=1}^{l}p_i^{k_i}&space;\prod&space;_{i=1}^{l}&space;(&space;1-\frac{1}{p_i})\\&space;&=n&space;\prod&space;_{i=1}^{l}&space;(&space;1-\frac{1}{p_i})\\&space;\end{aligned}&space;)

And , ![](https://latex.codecogs.com/gif.latex?\sigma(n)) represents the sum of all factors of n.
e.g. : ![](https://latex.codecogs.com/gif.latex?\sigma(9)&space;=&space;1+3+9&space;=&space;14)
![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;\sigma(n)&space;&=&space;\prod&space;_{i=1}^{l}&space;\sum_{j=0}^{k_i}&space;p_i^j&space;\\&space;&=\prod&space;_{i=1}^{l}&space;\frac{p_i^{k_i+1}-1}{p_i-1}\\&space;\end{aligned}&space;)

A `perfect number` _n_ is defined as ![](https://latex.codecogs.com/gif.latex?\sigma(n)&space;=&space;2n)
The following is the implementation of this two functions.

```python
from factor import factor
from collections import Counter
from functools import reduce
from operator import mul
def phi(n):
    st  = set(factor(n))
    return round(reduce(mul,(1-1/p for p in st),n))

def sigma(n):
    ct = Counter(factor(n))
    return reduce(mul,(round((p**(ct[p]+1)-1)/(p-1)) for p in ct),1)
```

<a id="markdown-05-modulo-equation" name="05-modulo-equation"></a>
## 0.5. Modulo equation  
The following codes can solve a linear, group modulo equation. More details and explanations will be supplied if I am not too busy.

Note that I use `--` to represent ![](https://latex.codecogs.com/gif.latex?\equiv) in the python codes.
![](https://upload-images.jianshu.io/upload_images/7130568-be31bdaf6b67f883.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


```python
import re

from gcd import xgcd
from euler import phi
from isPrime import isPrime
from factor import factor

def  ind(m,g):
    ''' mod m ,primary root g  ->  {n:indg n}'''
    return {j:i for i in range(m-1) \
            for j in range(m) if (g**i-j)%m==0}

def gs(m,num=100):
    '''return list of  m's  primary roots below num'''
    p = phi(m)
    mp = factor(p)
    checkLst = [p//i for i in mp]
    return [i for i in range(2,num) if all((i**n-1)%m !=0  for n in checkLst)]

def minG(m):
    p = phi(m)
    mp = factor(p)
    checkLst = [p//i for i in mp]
    i=2
    while  1:
        if all((i**n-1)%m !=0  for n in checkLst):return i
        i+=1

class solve:
    def __init__(self,equ=None):
        self.linearPat= re.compile(r'\s*(\d+)\s*--\s*(\d+)[\s\(]*mod\s*(\d+)')
        self.sol  = []
        #self.m = m
        #self.ind_mp = ind(m,minG(m))
    def noSol(self):
        print('equation {equ} has no solution'.format(equ=self.equ))
    def error(self):
        print("Error! The divisor m must be postive integer")
    def solveLinear(self,a,b,m):
        '''ax--b(mod m): solve linear equation with one unknown
            return  ([x1,x2,...],m)
        '''
        a,b,m = self.check(a,b,m)
        g,x,y=xgcd(a,m)
        if a*b%g!=0:
            self.noSol()
            return None
        sol=x*b//g
        m0 = m//g
        sols = [(sol+i*m0)%m for i in range(g)]
        print('{}x--{}(mod {}), solution: {} mod {}'.format(a,b,m,sols,m))
        return (sols,m)
    def check(self,a,b,m):
        if m<=0:
            self.error()
            return None
        if a<0:a,b=-a,-b  ## important
        if b<0:b+= -b//m * m
        return a,b,m

    def solveHigh(self,a,n,b,m):
        ''' ax^n -- b (mod m)  ind_mp is a dict of  m's {n: indg n}'''
        ind_mp = ind(m,minG(m))
        tmp = ind_mp[b] - ind_mp[a]
        if tmp < 0:tmp+=m
        sol = self.solveLinear(n,tmp,phi(m))
        re_mp = {j:i for i ,j in ind_mp.items()}
        sols = [re_mp[i] for i in sol[0]]
        print('{}x^{}--{}(mod {}),  solution: {} mod {}'.format(a,n,b,m,sols,m))
        return sols,m

    def solveGroup(self,tups):
        '''tups is a list of tongyu equation groups, like
            [(a1,b1,m1),(a2,b2,m2)...]
            and, m1,m2... are all primes
        '''
        mp = {}
        print('solving group of equations: ')
        for a,b,m in tups:
            print('{}x--{}(mod {})'.format(a,b,m))
            if m in mp:
                if mp[m][0]*b!=mp[m][1]*a:
                    self.noSol()
                    return
            else:mp[m] = (a,b)
        product = 1
        for i in mp.keys():
            product *=i
        sol = [0]
        for i in mp:
            xs,m = self.solveLinear(product//i*mp[i][0],1,i)
            new = []
            for x in xs:
                cur = x*product//i*mp[i][1]
                for old in sol:
                    new.append(old+cur)
            sol = new
        sol= [i%product for i in sol]
        print('final solution: {} mod {}'.format(sol,product))
        return sol,product
    def __call__(self):
        s=input('输入同余方程，用--代表同于号，形如3--5(mod 7)代表3x模7同余于5')
        li= self.linearPat.findall(s)
        li = [(int(a),int(b),int(m)) for a,b,m in li]
        print(self.solveLinear(li[0]))


if __name__ == '__main__':
    solver  = solve()
    res = solver.solveLinear(3,6,9)
    print()
    res = solver.solveHigh(1,8,3,11)
    print()
    res = solver.solveGroup([(5,11,2),(3,8,5),(4,1,7)])
```

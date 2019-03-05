---
title: String-Mathching-Algorithm
date: 2018-12-11  15:21
categories: 数据结构与算法
tags: [算法,字符串匹配,KMP,动态规划]
keywords:  
mathjax: true
description: 
---

See more on [github](https://github.com/mbinary/algorithm-in-python)

In this article, I will show you some kinds of popular string matching algorithm and  dynamic programming  algorithm for wildcard matching.

<!-- more -->
# String Matching algorithm
![](https://upload-images.jianshu.io/upload_images/7130568-e10dc137e9083a0e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Rabin-Karp
We can view a string of k characters (digits) as a length-k decimal number.  E.g., the string “31425” corresponds to the decimal number 31,425.
- Given a pattern P [1..m], let p denote the corresponding decimal value.
- Given a text T [1..n], let $t_s$ denote the decimal value of the length-m substring  T [(s+1)..(s+m)] for s=0,1,…,(n-m).
- let `d` be the radix of num, thus $d = len(set(s))$
- $t_s$ = p iff T [(s+1)..(s+m)] = P [1..m].
- p can be computed in O(m) time. p = P[m] + d\*(P[m-1] + d\*(P[m-2]+…)).
- $t_0$ can similarly be computed in O(m) time.
- Other $t_1,\ldots,t_{n-m}$ can be computed in O(n-m) time since $t_{s+1} can be computed from ts in constant time.

Namely, 
$$ 
t_{s+1} = d*(t_s-d^{m-1} * T[s+1])+T[s+m+1]
$$
However, it's no need to calculate $t_{s+1}$ directly. We can use modulus operation to reduce the work of caculation.

We choose a small prime number. Eg 13 for radix( denoted as d) 10.
Generally, $d*q$ should fit within one computer word.

We firstly caculate $t_0$ mod q.
Then, for every $t_i (i>1)$
assume
$$
 t_{i-1} = T[i+m-1] + d*T[i+m-2]+\ldots+d^{m-1}*T[i-1]
$$
denote $ d' = d^{m-1}\ mod\ q$
thus,
$$
\begin{aligned}
t_i &= (t_{i-1} - d^{m-1}*T[i-1]) * d + T[i+m]\\
&\equiv (t_{i-1} - d^{m-1}*T[i-1]) * d + T[i+m] (mod\ q)\\
&\equiv (t_{i-1}- ( d^{m-1} mod \ q) *T[i-1]) * d + T[i+m] (mod\ q)\\
&\equiv (t_{i-1}- d'*T[i-1]) * d + T[i+m] (mod\ q)
\end{aligned}
$$

So we can compare the modular value of each $t_i$ with p's.
Only if they are the same, then we compare the origin chracters, namely 
$$T[i],T[i+1],\ldots,T[i+m-1]$$ 
and the pattern characters.
Gernerally, this algorithm's time approximation is O(n+m), and the worst case is O((n-m+1)*m)

**Problem: this is assuming p and $t_s$ are small numbers. They may be too large to work with easily.**


python implementation
```python
#coding: utf-8
''' mbinary
#########################################################################
# File : rabin_karp.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.github.io
# Github: https://github.com/mbinary
# Created Time: 2018-12-11  00:01
# Description: rabin-karp algorithm
#########################################################################
'''

def isPrime(x):
    for i in range(2,int(x**0.5)+1):
        if x%i==0:return False
    return True
def getPrime(x):
    '''return a prime which is bigger than x'''
    for i in range(x,2*x):
        if isPrime(i):return i
def findAll(s,p):
    '''s: string   p: pattern'''
    dic={}
    n,m = len(s),len(p)
    d=0 #radix
    for c in s:
        if c not in dic:
            dic[c]=d
            d+=1
    sm = 0
    for c in p:
        if c not in dic:return []
        sm = sm*d+dic[c]

    ret = []
    cur = 0
    for i in range(m): cur=cur*d + dic[s[i]]
    if cur==sm:ret.append(0)
    tmp = n-m
    q = getPrime(m)
    cur = cur%q
    sm = sm%q
    exp = d**(m-1) % q
    for i in range(m,n):
        cur = ((cur-dic[s[i-m]]*exp)*d+dic[s[i]]) % q
        if cur == sm and p==s[i-m+1:i+1]:
            ret.append(i-m+1)
    return ret

def randStr(n=3):
    return [randint(ord('a'),ord('z')) for i in range(n)]

if __name__ =='__main__':
    from random import randint
    s = randStr(50)
    p = randStr(1)
    print(s)
    print(p)
    print(findAll(s,p))
```
## FSM
A FSM can be represented as $(Q,q_0,A,S,C)$, where
- Q is the set of all states
- $q_0$ is the start state
- $A\in Q$ is a set of accepting states.
- S is a finite input alphabet.
- C is the set of transition functions: namely  $q_j = c(s,q_i)$.

Given a pattern string S, we can build a FSM for string matching.
Assume S has m chars, and there should be m+1 states. One is for the begin state, and the others are for matching state of each position of S.

Once we have built the FSM, we can run it on any input string.
## KMP
>Knuth-Morris-Pratt method

The idea is inspired by FSM. We can avoid computing the transition functions. Instead, we compute a prefix function P in O(m) time, which has only m entries.
> Prefix funtion stores info about how the pattern matches against shifts of itself.

- String w is a prefix of string x, if x=wy for some string y
- String w is a suffix of string x, if x=yw for some string y
- The k-character prefix of the pattern P [1..m] denoted by Pk.
- Given that pattern prefix P [1..q] matches text characters T [(s+1)..(s+q)], what is the least shift s'> s such that P [1..k] = T [(s'+1)..(s'+k)] where s'+k=s+q?
- At the new shift s', no need to compare the first k characters of P with corresponding characters of T.
Method: For prefix $p_i$, find the longest proper prefix of $p_i$ that is also a suffix of $p_i$.
$$
pre[q] = max\{k|k<q , p_k \text{is a suffix of } p_q\}
$$

For example:  p = ababaca,
Then,
$p_5$ = ababa, pre[5] = 3. 
Namely $p_3$=aba is the longest prefix of p that is also a suffix of $p_5$.

Time approximation: finding prefix function take O(m), matching takes O(m+n)

python implementation
```python
#coding: utf-8
''' mbinary
#########################################################################
# File : KMP.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.github.io
# Github: https://github.com/mbinary
# Created Time: 2018-12-11  14:02
# Description:
#########################################################################
'''

def getPrefixFunc(s):
    '''return the list of prefix function of s'''
    length = 0
    i = 1
    n = len(s)
    ret = [0]
    while i<n:
        if s[i]==s[length]:
            length +=1
            ret.append(length)
            i+=1
        else:
            if length==0:
                ret.append(0)
                i+=1
            else:
                length = ret[length-1]
    return ret

def findAll(s,p):
    pre = getPrefixFunc(p)
    i = j  =0
    n,m = len(s),len(p)
    ret = []
    while i<n:
        if s[i]==p[j]:
            i+=1
            j+=1
            if j==m:
                ret.append(i-j)
                j=pre[j-1]
        else:
            if j==0: i+=1
            else: j = pre[j-1]
    return ret
def randStr(n=3):
    return [randint(ord('a'),ord('z')) for i in range(n)]

if __name__ =='__main__':
    from random import randint
    s = randStr(50)
    p = randStr(1)
    print(s)
    print(p)
    print(findAll(s,p))
```
## Boyer-Moore
- The longer the pattern is, the faster it works.
- Starts from the end of pattern, while KMP starts from the beginning.
- Works best for character string, while KMP works best for binary string.
- KMP and Boyer-Moore
  - Preprocessing existing patterns.
  - Searching patterns in input strings.

## Sunday
### features
- simplification of the Boyer-Moore algorithm;
- uses only the bad-character shift;
- easy to implement;
- preprocessing phase in O(m+sigma) time and O(sigma) space complexity;
- searching phase in O(mn) time complexity;
- very fast in practice for short patterns and large alphabets.
### description
The Quick Search algorithm uses only the bad-character shift table (see chapter Boyer-Moore algorithm). After an attempt where the window is positioned on the text factor y[j .. j+m-1], the length of the shift is at least equal to one. So, the character y[j+m] is necessarily involved in the next attempt, and thus can be used for the bad-character shift of the current attempt.

The bad-character shift of the present algorithm is slightly modified to take into account the last character of x as follows: for c in Sigma, qsBc[c]=min{i : 0  < i leq m and x[m-i]=c} if c occurs in x, m+1 otherwise (thanks to Darko Brljak).

The preprocessing phase is in O(m+sigma) time and O(sigma) space complexity.

During the searching phase the comparisons between pattern and text characters during each attempt can be done in any order. The searching phase has a quadratic worst case time complexity but it has a good practical behaviour.

For instance,
![image.png](https://upload-images.jianshu.io/upload_images/7130568-76d130ae24603d51.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

In this example, t0, ..., t4 =  a b c a b is the current text window that is compared with the pattern. Its suffix a b has matched, but the comparison c-a causes a mismatch. The bad-character heuristics of the Boyer-Moore algorithm (a) uses the "bad" text character c to determine the shift distance. The Horspool algorithm (b) uses the rightmost character b of the current text window. The Sunday algorithm (c) uses the character directly right of the text window, namely d in this example. Since d does not occur in the pattern at all, the pattern can be shifted past this position.

python implementation
```python
''' mbinary
#########################################################################
# File : sunday.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.github.io
# Github: https://github.com/mbinary
# Created Time: 2018-07-11  15:26
# Description: 字符串模式匹配, sunday 算法, kmp 的改进
#               pattern matching for strings using sunday algorithm
#########################################################################
'''



def getPos(pattern):
    dic = {}
    for i,j in enumerate(pattern[::-1]):
        if j not in dic:
            dic[j]= i
    return dic
def find(s,p):
    dic = getPos(p)
    ps = pp = 0
    ns = len(s)
    np = len(p)
    while ps<ns and pp<np:
        if s[ps] == p[pp]:
            ps,pp = ps+1,pp+1
        else:
            idx = ps+ np-pp
            if idx >=ns:return -1
            ch = s[idx]
            if ch in dic:
                ps += dic[ch]+1-pp
            else:
                ps = idx+1
            pp = 0
    if pp==np:return ps-np
    else:
        return -1
def findAll(s,p):
    ns = len(s)
    np = len(p)
    i = 0
    ret = []
    while s:
        print(s,p)
        tmp = find(s,p)
        if tmp==-1: break
        ret.append(i+tmp)
        end = tmp+np
        i +=end
        s = s[end:]
    return ret



def randStr(n=3):
    return [randint(ord('a'),ord('z')) for i in range(n)]

def test(n):
    s = randStr(n)
    p = randStr(3)
    str_s = ''.join((chr(i) for i in s))
    str_p = ''.join((chr(i) for i in p))
    n1 = find(s,p)
    n2 = str_s.find(str_p) # 利用已有的 str find 算法检验
    if n1!=n2:
        print(n1,n2,str_p,str_s)
        return False
    return True
if __name__ =='__main__':
    from random import randint
    n = 1000
    suc = sum(test(n) for i in range(n))
    print('test {n} times, success {suc} times'.format(n=n,suc=suc))
```


# WildCard matching
 ![divider](/uploads/divider.png)
wild card:
- `*`  matches 0 or any chars
- `?` matches any single char.

Given a string `s` which doesn't include wild card, 
    and a pattern `p` which includes wild card,

Judge if they are matching.

## Idea
Using dynamic programming.

n = length(s),  m = length(p)

dp[m+1][n+1]:  bool

i:n,  j:m
dp[j][i] represents if s[:i+1] matches p[:j+1]

initialzation : 
dp[0][0] = True, dp[0][i],dp[j][0] = False, only if p startswith '*',  dp[1][0] = True.

if   p[j] = '*': dp[j][i] = dp[j-1][i] or dp[j][i-1]
elif p[j] = '?': dp[j][i] = dp[j-1][i-1]
else           : dp[j][i] = dp[j-1][i-1] and s[i] == p[j]


## Code
```python
def isMatch(self, s, p):
    """
    :type s: str
    :type p: str   pattern str including wildcard
    :rtype: bool
    """
    n,m = len(s),len(p)
    last =  [False]*(n+1)
    last[0] = True
    for j in range(m):
        if p[j]=='*':
            for i in range(n):
                last[i+1] = last[i+1] or last[i]
        elif p[j]=='?':
            last.pop()
            last.insert(0,False)
        else:
            li = [False]
            for i in range(n):
                li.append( last[i] and p[j]==s[i])
            last = li
    return last[-1]
```
# Reference:
1. Xuyun, ppt, String matching
2. [Sunday-algorithm](http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sunday.htm)
3. GeeksforGeeks, [KMP Algorithm](https://www.geeksforgeeks.org/kmp-algorithm-for-pattern-searching/)
4. Augustliang, csdn, [dynamic programming for wild card matching](https://blog.csdn.net/glDemo/article/details/47678159)

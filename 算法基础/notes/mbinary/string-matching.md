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
- Given a text T [1..n], let ![](https://latex.codecogs.com/gif.latex?t_s) denote the decimal value of the length-m substring  T [(s+1)..(s+m)] for s=0,1,…,(n-m).
- let `d` be the radix of num, thus ![](https://latex.codecogs.com/gif.latex?d&space;=&space;len(set(s)))
- ![](https://latex.codecogs.com/gif.latex?t_s) = p iff T [(s+1)..(s+m)] = P [1..m].
- p can be computed in O(m) time. p = P[m] + d\*(P[m-1] + d\*(P[m-2]+…)).
- ![](https://latex.codecogs.com/gif.latex?t_0) can similarly be computed in O(m) time.
- Other ![](https://latex.codecogs.com/gif.latex?t_1,\ldots,t_{n-m}) can be computed in O(n-m) time since ![](https://latex.codecogs.com/gif.latex?t_{s+1}&space;can&space;be&space;computed&space;from&space;ts&space;in&space;constant&space;time.&space;Namely,&space;) 
t_{s+1} = d*(t_s-d^{m-1} * T[s+1])+T[s+m+1]
![](https://latex.codecogs.com/gif.latex?&space;However,&space;it's&space;no&space;need&space;to&space;calculate)t_{s+1}![](https://latex.codecogs.com/gif.latex?directly.&space;We&space;can&space;use&space;modulus&space;operation&space;to&space;reduce&space;the&space;work&space;of&space;caculation.&space;We&space;choose&space;a&space;small&space;prime&space;number.&space;Eg&space;13&space;for&space;radix(&space;denoted&space;as&space;d)&space;10.&space;Generally,)d*q![](https://latex.codecogs.com/gif.latex?should&space;fit&space;within&space;one&space;computer&space;word.&space;We&space;firstly&space;caculate)t_0![](https://latex.codecogs.com/gif.latex?mod&space;q.&space;Then,&space;for&space;every)t_i (i>1)![](https://latex.codecogs.com/gif.latex?&space;assume&space;)
 t_{i-1} = T[i+m-1] + d*T[i+m-2]+\ldots+d^{m-1}*T[i-1]
![](https://latex.codecogs.com/gif.latex?&space;denote) d' = d^{m-1}\ mod\ q![](https://latex.codecogs.com/gif.latex?&space;thus,&space;)
\begin{aligned}
t_i &= (t_{i-1} - d^{m-1}*T[i-1]) * d + T[i+m]\\
&\equiv (t_{i-1} - d^{m-1}*T[i-1]) * d + T[i+m] (mod\ q)\\
&\equiv (t_{i-1}- ( d^{m-1} mod \ q) *T[i-1]) * d + T[i+m] (mod\ q)\\
&\equiv (t_{i-1}- d'*T[i-1]) * d + T[i+m] (mod\ q)
\end{aligned}
![](https://latex.codecogs.com/gif.latex?&space;So&space;we&space;can&space;compare&space;the&space;modular&space;value&space;of&space;each)t_i![](https://latex.codecogs.com/gif.latex?with&space;p's.&space;Only&space;if&space;they&space;are&space;the&space;same,&space;then&space;we&space;compare&space;the&space;origin&space;chracters,&space;namely&space;)T[i],T[i+1],\ldots,T[i+m-1]![](https://latex.codecogs.com/gif.latex?&space;and&space;the&space;pattern&space;characters.&space;Gernerally,&space;this&space;algorithm's&space;time&space;approximation&space;is&space;O(n+m),&space;and&space;the&space;worst&space;case&space;is&space;O((n-m+1)*m)&space;**Problem:&space;this&space;is&space;assuming&space;p&space;and)t_s![](https://latex.codecogs.com/gif.latex?are&space;small&space;numbers.&space;They&space;may&space;be&space;too&space;large&space;to&space;work&space;with&space;easily.**&space;python&space;implementation&space;```python&space;#coding:&space;utf-8&space;'''&space;mbinary&space;#########################################################################&space;#&space;File&space;:&space;rabin_karp.py&space;#&space;Author:&space;mbinary&space;#&space;Mail:&space;zhuheqin1@gmail.com&space;#&space;Blog:&space;https://mbinary.github.io&space;#&space;Github:&space;https://github.com/mbinary&space;#&space;Created&space;Time:&space;2018-12-11&space;00:01&space;#&space;Description:&space;rabin-karp&space;algorithm&space;#########################################################################&space;'''&space;def&space;isPrime(x):&space;for&space;i&space;in&space;range(2,int(x**0.5)+1):&space;if&space;x%i==0:return&space;False&space;return&space;True&space;def&space;getPrime(x):&space;'''return&space;a&space;prime&space;which&space;is&space;bigger&space;than&space;x'''&space;for&space;i&space;in&space;range(x,2*x):&space;if&space;isPrime(i):return&space;i&space;def&space;findAll(s,p):&space;'''s:&space;string&space;p:&space;pattern'''&space;dic={}&space;n,m&space;=&space;len(s),len(p)&space;d=0&space;#radix&space;for&space;c&space;in&space;s:&space;if&space;c&space;not&space;in&space;dic:&space;dic[c]=d&space;d+=1&space;sm&space;=&space;0&space;for&space;c&space;in&space;p:&space;if&space;c&space;not&space;in&space;dic:return&space;[]&space;sm&space;=&space;sm*d+dic[c]&space;ret&space;=&space;[]&space;cur&space;=&space;0&space;for&space;i&space;in&space;range(m):&space;cur=cur*d&space;+&space;dic[s[i]]&space;if&space;cur==sm:ret.append(0)&space;tmp&space;=&space;n-m&space;q&space;=&space;getPrime(m)&space;cur&space;=&space;cur%q&space;sm&space;=&space;sm%q&space;exp&space;=&space;d**(m-1)&space;%&space;q&space;for&space;i&space;in&space;range(m,n):&space;cur&space;=&space;((cur-dic[s[i-m]]*exp)*d+dic[s[i]])&space;%&space;q&space;if&space;cur&space;==&space;sm&space;and&space;p==s[i-m+1:i+1]:&space;ret.append(i-m+1)&space;return&space;ret&space;def&space;randStr(n=3):&space;return&space;[randint(ord('a'),ord('z'))&space;for&space;i&space;in&space;range(n)]&space;if&space;__name__&space;=='__main__':&space;from&space;random&space;import&space;randint&space;s&space;=&space;randStr(50)&space;p&space;=&space;randStr(1)&space;print(s)&space;print(p)&space;print(findAll(s,p))&space;```&space;##&space;FSM&space;A&space;FSM&space;can&space;be&space;represented&space;as)(Q,q_0,A,S,C)![](https://latex.codecogs.com/gif.latex?,&space;where&space;-&space;Q&space;is&space;the&space;set&space;of&space;all&space;states&space;-)q_0![](https://latex.codecogs.com/gif.latex?is&space;the&space;start&space;state&space;-)A\in Q![](https://latex.codecogs.com/gif.latex?is&space;a&space;set&space;of&space;accepting&space;states.&space;-&space;S&space;is&space;a&space;finite&space;input&space;alphabet.&space;-&space;C&space;is&space;the&space;set&space;of&space;transition&space;functions:&space;namely)q_j = c(s,q_i)![](https://latex.codecogs.com/gif.latex?.&space;Given&space;a&space;pattern&space;string&space;S,&space;we&space;can&space;build&space;a&space;FSM&space;for&space;string&space;matching.&space;Assume&space;S&space;has&space;m&space;chars,&space;and&space;there&space;should&space;be&space;m+1&space;states.&space;One&space;is&space;for&space;the&space;begin&space;state,&space;and&space;the&space;others&space;are&space;for&space;matching&space;state&space;of&space;each&space;position&space;of&space;S.&space;Once&space;we&space;have&space;built&space;the&space;FSM,&space;we&space;can&space;run&space;it&space;on&space;any&space;input&space;string.&space;##&space;KMP&space;>Knuth-Morris-Pratt&space;method&space;The&space;idea&space;is&space;inspired&space;by&space;FSM.&space;We&space;can&space;avoid&space;computing&space;the&space;transition&space;functions.&space;Instead,&space;we&space;compute&space;a&space;prefix&space;function&space;P&space;in&space;O(m)&space;time,&space;which&space;has&space;only&space;m&space;entries.&space;>&space;Prefix&space;funtion&space;stores&space;info&space;about&space;how&space;the&space;pattern&space;matches&space;against&space;shifts&space;of&space;itself.&space;-&space;String&space;w&space;is&space;a&space;prefix&space;of&space;string&space;x,&space;if&space;x=wy&space;for&space;some&space;string&space;y&space;-&space;String&space;w&space;is&space;a&space;suffix&space;of&space;string&space;x,&space;if&space;x=yw&space;for&space;some&space;string&space;y&space;-&space;The&space;k-character&space;prefix&space;of&space;the&space;pattern&space;P&space;[1..m]&space;denoted&space;by&space;Pk.&space;-&space;Given&space;that&space;pattern&space;prefix&space;P&space;[1..q]&space;matches&space;text&space;characters&space;T&space;[(s+1)..(s+q)],&space;what&space;is&space;the&space;least&space;shift&space;s'>&space;s&space;such&space;that&space;P&space;[1..k]&space;=&space;T&space;[(s'+1)..(s'+k)]&space;where&space;s'+k=s+q?&space;-&space;At&space;the&space;new&space;shift&space;s',&space;no&space;need&space;to&space;compare&space;the&space;first&space;k&space;characters&space;of&space;P&space;with&space;corresponding&space;characters&space;of&space;T.&space;Method:&space;For&space;prefix)p_i![](https://latex.codecogs.com/gif.latex?,&space;find&space;the&space;longest&space;proper&space;prefix&space;of)p_i![](https://latex.codecogs.com/gif.latex?that&space;is&space;also&space;a&space;suffix&space;of)p_i![](https://latex.codecogs.com/gif.latex?.&space;)
pre[q] = max\{k|k<q , p_k \text{is a suffix of } p_q\}
![](https://latex.codecogs.com/gif.latex?&space;For&space;example:&space;p&space;=&space;ababaca,&space;Then,&space;)p_5![](https://latex.codecogs.com/gif.latex?=&space;ababa,&space;pre[5]&space;=&space;3.&space;Namely)p_3![](https://latex.codecogs.com/gif.latex?=aba&space;is&space;the&space;longest&space;prefix&space;of&space;p&space;that&space;is&space;also&space;a&space;suffix&space;of)p_5$.

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

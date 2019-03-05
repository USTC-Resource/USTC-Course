''' mbinary
#########################################################################
# File : lcs.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-08-25  12:00
# Description:
#########################################################################
'''

def lcs(a,b):
    '''time: O(mn); space: O(mn)'''
    m,n= len(a),len(b)
    board = [[[] for i in range(n+1)] for i in range(m+1)]
    for i in range(m):
        for j in range(n):
            if a[i]==b[j]:
                board[i+1][j+1] =board[i][j]+[a[i]]
            elif len(board[i][j+1]) < len(board[i+1][j]):
                board[i+1][j+1] = board[i+1][j]
            else :
                board[i+1][j+1] = board[i][1+j]
    return board[m][n]

def lcs2(a,b):
    '''time: O(mn); space: O(min(m,n))'''
    if len(b)>len(a):
        a,b= b,a
    m,n = len(a),len(b)
    board = [[] for i in range(n+1)]
    for i in range(m):
        upperLevel = board[0].copy()
        for j in range(n):
            tmp = board[j+1].copy()
            if a[i]==b[j]:
                board[j+1] = upperLevel+[a[i]]
            elif len(board[j+1]) < len(board[j]):
                board[j+1] = board[j].copy() # copy is needed
            upperLevel = tmp
    return board[n]

if __name__ =='__main__':
    a = 'ABCBDAB'
    b = 'BDCABA'
    print('s1:',a)
    print('s2:',b)
    while 1:
        print('lcs:',lcs2(a,b))
        a = input('s1: ')
        b = input('s2: ')

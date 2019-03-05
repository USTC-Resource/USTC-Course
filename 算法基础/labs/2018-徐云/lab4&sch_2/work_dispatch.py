'''
设有n件工作要分配给n个人去完成，将工作i分配给第j个人所需费用为c_ij 。试设计一个算法，为每个人分配1件不同的工作，并使总费用达到最小。
'''
def dispatch(mat):
    '''mat: matrix of c_ij'''
    def _util(i,arrange,cost):
        ''' for i-th  work'''
        nonlocal total,used,rst
        if i==n:
            total=cost
            rst = arrange.copy() # copy is needed
        else:
            for j in range(n):
                if not used[j] and( total is None or cost+mat[i][j]<total):
                    used[j]=True
                    arrange[i] = j
                    _util(i+1,arrange,cost+mat[i][j])
                    used[j]=False
    total = None
    rst = None
    n = len(mat)
    used = [False for i in range(n)]
    _util(0,[-1]*n,0)
    return total,rst


import random
if __name__=='__main__':
    n = 10
    mat = [[random.randint(1,100) for i in range(n)] for i in range(n)]
    print('work matrix: c_ij: work_i and person_j')
    for i in range(n):
        print(mat[i])
    print('result: ',end='')
    print(dispatch(mat))



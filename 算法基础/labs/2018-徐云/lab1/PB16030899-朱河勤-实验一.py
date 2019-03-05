from random import randint
from time import time
from functools import total_ordering

@total_ordering
class point:
    def __init__(self,x,y):
        self.x=x
        self.y=y
    def __neg__(self):
        return pont(-self.x, -self.y)
    def __len__(self):
        return self.norm(2)
    def __lt__(self,p):
        return self.x<p.x  or (self.x==p.x and self.y<p.y)
    def __eq__(self,p):
        return self.x==p.x and self.y == p.y
    def __hash__(self):
        return hash((self.x,self.y))
    def __repr__(self):
        return 'point({},{})'.format(self.x,self.y)
    def __str__(self):
        return self.__repr__()
    def norm(self,n=2):
        if n<=0: return max(abs(self.x),abs(self.y))
        return (abs(self.x)**n+abs(self.y)**n)**(1/n)
    def distance(self,p):
        return ((self.x-p.x)**2+(self.y-p.y)**2)**0.5

def minDistance_n2(points):
    n = len(points)
    if n<=1: return 0
    p,q=points[:2]
    minD = points[0].distance(points[1])
    for i in range(n-1):
        for j in range(i+1,n):
            d = points[i].distance(points[j])
            if d<minD:
                minD = d
                p = points[i]
                q= points[j]
    return minD, p,q

def findif(points, f,reverse = False):
    n = len(points)
    rg = range(n-1,-1,-1) if reverse else range(n)
    for i in rg: 
        if not  f(points[i]):
            return points[i+1:]  if reverse else points[:i]
    return points.copy() # note that don't return exactly points, return a copy one

def floatEql(f1,f2,epsilon=1e-6):
    return abs(f1-f2)<epsilon

def minDistance_nlogn(n_points):
    def _min(pts):
        n = len(pts)
        if n==2: return pts[0].distance(pts[1]) , pts[0],pts[1]
        if n==3:
            minD = pts[0].distance(pts[1])
            p,q = pts[0],pts[1]
            d2 = pts[2].distance(pts[1])
            if minD>d2:
                minD = d2
                p,q = pts[1], pts[2]
            d2 = pts[0].distance(pts[2])
            if minD>d2: return d2, pts[0],pts[2]
            else      : return minD, p,q
        n2 = n//2
        mid = (pts[n2].x +pts[n2-1].x)/2
        s1 = pts[:n2]
        s2 = pts[n2:]
        minD ,p,q = _min(s1)
        d2, p2, q2 = _min(s2)
        #print('\n\n',minD,p,q,s1)
        #print(d2,p2,q2,s2)
        if minD> d2:
            minD,p,q = d2, p2, q2

        linePoints = findif(s1,lambda pt:floatEql(pt.x,mid),reverse=True)
        linePoints += findif(s2,lambda pt:floatEql(pt.x,mid))
        n = len(linePoints)
        if n>1:
            for i in range(1,n):
                dis = linePoints[i].y -linePoints[i-1].y
                if dis<minD: 
                    minD = dis
                    p,q = linePoints[i-1], linePoints[i]
        leftPoints = findif(s1,lambda pt:pt.x>= mid-minD,reverse=True)
        rightPoints = findif(s2,lambda pt:pt.x<= mid+minD)
        for lp in leftPoints:
            y1,y2 = lp.y-minD, lp.y+minD
            for rp in rightPoints:
                if y1< rp.y <y2:
                    dis = lp.distance(rp)
                    if dis< minD:
                        minD = dis
                        p,q = lp,rp
        return minD, p,q
    return _min(sorted(n_points))

def test(f,points):
    print('\ntest  : ', f.__name__)
    begin = time()
    minD, p, q = f(points)
    print('time  : {:.6f} s'.format(time()-begin))
    print('result: {:.2f} {} {}\n'.format(minD, p,q))

def genData(n,unique=True):
    if unique:
        points = set()
        for i in range(n):
            points.add(point(randint(1,1000),randint(1,1000)))
        return list(points)
    else:return [point(randint(1,1000),randint(1,1000)) for i in range(n)]

def getInput(f):
    li =[]
    with open(f,'r') as fp:
        for line in fp:
            p  =line.find('//')
            if p!=-1:line = line[:p]
            li.append(line)
    s = ''.join(li)
    s = s.replace(' ','')
    li = s.split(';')
    points = [i.split(',') for i in li]
    return  [point(float(i[0]),float(i[1])) for i in points]
if __name__ =='__main__':
    import sys
    files = sys.argv[1:]
    if files !=[]:
        for f in sys.argv[1:]:
            points=getInput(f)
            print('min distance of points: {}'.format(points))
            test(minDistance_n2,points)
            test(minDistance_nlogn,points)
    else:
        n = 1000
        points = genData(n, unique=True)
        #print(sorted(points))
        print('min distance of {} points: '.format(n))
        test(minDistance_n2,points)
        test(minDistance_nlogn,points)

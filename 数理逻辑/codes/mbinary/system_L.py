'''
Name: formal deduction system   
Author: mbinary  
Time: 2018-3-6
Description:

use > to repr -> ,  ~ for 取反
read from left to right
eg p>~(q>~r)


i feel pretty sorry for that there  are possibly  some bugs.
I am striving to handle them.
If your find some or you have some good ideas about the method of proving,
please tell me, many thanks!


To do:
* 将证明过程对象化,便于处理,打印(英文版,中文版),
* 其他连接词的转换
* 处理简单的, 有一定模式的自然语言, 形成命题推理
'''

import re
import sympy
from random import  randint
from collections import namedtuple


NON = sympy.Symbol('~')
CONTAIN = sympy.Symbol('>')
AND = sympy .Symbol('&')
OR = sysmpy.Symbol('|')
EQUAL = sysmpy.Symbol('-')
LEFT = sympy.Symbol('(')
RIGHT = sympy.Symbol(')')

CONN=[NON,CONTAIN,LEFT,RIGHT]


PAIR = namedtuple('pair',['pre','suf'])

def non(p):
    li = p.getPreOrderLst()
    if li[0]==NON:return formula(li[1:])
    return formula([NON]+li)

def contain(p,q):
    '''p->q'''
    return formula([CONTAIN]+p.getPreOrderLst()+q.getPreOrderLst())
def isConn(p):
    return p in CONN


def in2pre(s):
    ''' 
        inorder symbols of list ->  prorder symbols of list
    '''
    def matchParentheses(i=0,reverse=False):
        '''match parentheses from one end  of s and ret pointer i'''
        delta = -1 if reverse is True else 1
        ct =0
        while 1:
            if s[i]==LEFT:ct-=1
            elif s[i]==RIGHT:ct+=1
            i+=delta
            if ct == 0:break
        try:
            while s[i]==NON:
                i+=delta
        except:pass
        return i

    n = len(s)
    if n<=2 :return s
    i = matchParentheses()
    if i==n and s[0]==LEFT and s[-1]==RIGHT:return in2pre(s[1:-1])
    if s[0]==NON and s[1]==LEFT and matchParentheses(1)==n and s[-1]==RIGHT:
        return [NON]+in2pre(s[2:-1])
    i=-1
    if s[-1]==RIGHT:i = matchParentheses(-1,True)
    else:
        while s[i]!=CONTAIN:i-=1
    return [CONTAIN]+in2pre(s[:i])+in2pre(s[i+1:])

class formula:
    def __init__(self,preOrderLst):
        self.preOrderLst = preOrderLst
        if not self.isValid(): raise Exception('invalid formula')
        self.inOrderLst = self.pre2in(self.preOrderLst)
        self.sz = len(self.preOrderLst)
    def __bool__(self): return bool(self.preOrderLst)
    def __len__(self):return self.sz
    def __getitem(self,i):return self.preOrderLst[i]
    def __iter__(self):return iter(self.preOrderLst)
    def __repr__(self): return 'formula({})'.format(str(self))
    def __str__(self):return ''.join([str(i) for i in self.inOrderLst])
    def __hash__(self):return hash(''.join([str(i) for i in self.preOrderLst]))
    def __eq__(self,x):
        return isinstance(x,formula) and self.preOrderLst == x.preOrderLst
    def getPreOrderLst(self):return self.preOrderLst
    def getInOrderLst(self):return self.inOrderLst
    
    def isValid(self):
        return self.validSub(self.preOrderLst)[0]
    def isNonType(self):
        '''return  True if it's ~p form'''
        return self.preOrderLst[0]==NON
    
    def validSub(self,s=None,begin=0,end=None):
        '''
            check a *preOrder-list* s from left of its preOrderLst
            until forming a valid proposition
            return ('if s[begin:end] froms a  valid prop' , the index)
            return:  (bool,int)
        '''
        
        weight={NON:0,CONTAIN:-1}  # proposition varible :1
        if s is None:s = self.preOrderLst 
        
        def w(sym):
            return weight[sym] if sym in weight else 1
        
        ct,i  = 0,begin
        n = len(s) if end is None else end
        while ct !=1 and i!=n:
            ct+=w(s[i])
            i+=1
        return (ct==1 and i==n,i)
    def getPairs(self):
        '''return Pairs of formulas likr[(p,q)...] after applying enough p2p func,
            eg q>(~r>(~t>s)): return [(q,~r>(~t>s)),(~r,~t>s),(~t,s)]
        '''
        s = []  
        cur = self
        while 1:
            p,q = cur.p2q()
            if q is None:return s
            s.append(PAIR(p,q))
            cur = q
            
    def p2q(self,fm=None):
        '''
            if f can be formed in the form of  p->q:  return (p,q),  
            else return f,None
            p,q,f are all formula s
        '''
        if fm is None: fm = self
        f = fm.preOrderLst
        n=len(f)
        ct,i = self.getContNonNum(f,0)
        if n>=3 and ct%2==0 and f[i]==CONTAIN :
            _,i= self.validSub(f,begin=i+1)
            if i!=n: return formula(f[1:i]),formula(f[i:])
        return fm,None
    
    def getContNonNum(self,s=None,i=0):
        '''
            visit s from i until s[i] isn't NON,
            then return the num of continuous NON  and the pointer i
        '''
        if s is None:s = self.preOrderLst
        ct=0
        while s and s[i]==NON:
            i+=1
            ct+=1
        return ct,i
    def pre2in(self,li,begin=0):
        ''' li is a list of preorder symbols repring a proposition
            this func converts it to preorder form(probably  contains parentheses)
        '''
        def addParentheses(li):
            return [LEFT]+li +[RIGHT] if len(li)>=3  else li
        
        self.pt = begin
        
        if not li :return []
        if li[self.pt]==NON:
            ct ,self.pt= self.getContNonNum(li,self.pt)
            nn=[NON] if ct%2==1 else []
            if li[self.pt] == CONTAIN:
                return nn + addParentheses(self.pre2in(li,self.pt))
            else:
                nn.append(li[self.pt])
                self.pt+=1
                return nn
        elif li[self.pt] == CONTAIN:
            self.pt +=1
            ct, lst = 0, []
            last = self.pt
            while ct!=1:
                tmp = li[self.pt]
                self.pt+=1
                if not isConn(tmp):ct+=1
                elif tmp==CONTAIN:ct-=1
            return addParentheses(self.pre2in(li,last)) \
                   +[CONTAIN]+ addParentheses(self.pre2in(li,self.pt))
        else:
            self.pt+=1
            return [li[self.pt-1]]

class  system_L:
    def __init__(self):
        pass
    def l1(self,p,q):
        '''p->(q->p)'''
        return contain(p,contain(q,p))
    def l2(self,p,q,r):
        '''p->(q->r)'''
        origin = contain(p,contain(q,r))
        new = contain(contain(p,q),contain(p,r))
        return contain(origin,new)
    def l3(self,p,q):
        '''~p->~q -> (p->q)'''
        left = contain(non(p),non(q))
        right = contain(p,q)
        return contain(left,right)
    def genFormula(self,s:str)->formula:
        s=s.replace('~~','')  #  simplify the deduction,  to do
	s=s.replace('<->','-')
        s=s.replace('->','>')
        li = re.findall(r'[\(\)\>\~]|\w+',s)
        li = [sympy.Symbol(i) for i in li]
        s = in2pre(li)
        return formula(s)

    def addL1(self,i,p,q,tmp_mp):
        '''i = p>q,加入由 否定前件律 或 L1 得来的公式'''
        if not p.isNonType():
            #  p>q or p>~q: get  ~p>(p>q)
            tmp_mp[contain(non(p),i)] = ([],'否定前件律')
        if not q.isNonType():
            # p>q  :  get theorem  q>(p>q)
            tmp_mp[contain(q,i)] = ([],'L1')

    def addMP(self,i,p,q,tmp_mp):
        '''i=p>q 加入由 换位律 或 MP 得来的公式'''
        if p.isNonType() and q.isNonType():
            # p=~a,q=~b:   ~a->~b ->(b->a)
            nonpq = contain(non(q),non(p))
            comb = contain(i,nonpq)
            tmp_mp[comb] = ([],'L3')
            tmp_mp[nonpq] = ([i,comb],'MP')
        elif not p.isNonType() and not q.isNonType():
            # p->q ->(~q->~p)
            pq = contain(non(q),non(p))
            comb = contain(i,pq)
            tmp_mp[comb] = ([],'换位律')
            
            tmp_mp[pq] = ([i,comb],'MP')
    def addTheo(self,li,mp):
        def _iterLst(li,f):
            tmp_mp = {}
            for i in li:
                p,q = i.p2q()
                if q is None:
                    i = non(i)
                    p,q = i.p2q()
                if q is None:continue
                f(i,p,q,tmp_mp)
            return tmp_mp
            
        tmp_mp = _iterLst(li,self.addMP)
        tmp_mp.update( _iterLst(li,self.addMP))
        for i in tmp_mp:
            if i not in mp:mp[i]= tmp_mp[i]

        lst = [ i.pre  for p in mp for i in p.getPairs() if i not in mp]
        tmp_mp= _iterLst(lst,self.addL1)
        for i in tmp_mp:
            if i not in mp:mp[i]= tmp_mp[i]

    def mpDeduce(self,formulas,x,mp=None):

        def getIdx(x):
            '''insert x in deduction and get idx of it, var ct, mp is in the outer func'''
            if x in appeared:return appeared[x]
            li, wds = mp[x]
            for p in li:
                wds += ' [{}]'.format(getIdx(p))
            deduction.append((x,wds))
            nonlocal ct
            ct+=1
            appeared[x] = ct
            return ct
        
        def _mpDeduce(x):
            if x in proved:
                return mp[x] if x in mp else None
            proved[x]=True
            if x in mp:return mp[x]
            
            li = []
            # x在fomrulas 中的 可能的证明: [p1,p2,p3...,x]  的列表
            
            for p in mp :
                pairs =p.getPairs()
                for idx, pair in enumerate(pairs):
                    if pair.suf == x:
                        li.append(pairs[:idx+1])
                        break
            
            for pairs in li:
                for pre,suf in pairs:
                    if suf in mp:continue
                    tmp = _mpDeduce(pre)
                    if tmp is not None:
                        mp[pre]=tmp
                        mp[suf] = ([pre,contain(pre,suf)],'MP')
                    else:break
                else:return mp[x]
            return  None

        if mp is None:mp={i:([],'假定') for i in formulas}
        proved = {}
        tmp  =  _mpDeduce(x)
        if tmp is None:
            return None
        mp[x] = tmp
        ct,deduction, appeared = 0,[], {}
        tmp=getIdx(x)
        return deduction


    def nonDeduce(self,formulas,x,mp=None):
        '''反证法,归谬法'''
        if mp is None: mp={i:([],'假定') for i in formulas}
        mp[non(x)] = ([],'假定')
        formulas.append(non(x))
        self.addTheo([non(x)],mp)
        nonSet = []
        for i in mp:
            if i.isNonType():nonSet.append(i)
            pairs = i.getPairs()
            if pairs and  pairs[-1].suf.isNonType():
                nonSet.append(pairs[-1].suf)
                
        meth ='归谬法'  if x.isNonType() else '反证法'
        
        for i in nonSet:
            p1 = self.mpDeduce(formulas,i,mp)
            p2 = self.mpDeduce(formulas,non(i),mp)
            if p1 is None or p2 is None:continue
            else:
                s = '由{meth},即证(1) {{{formulas}}} |- {p}\n            (2) {{{formulas}}} |- {nonp}'\
                    .format(meth=meth,formulas=','.join([str(i) for i in formulas]),p=i,nonp=non(i))
                return s, p1, p2
        return None,None,None
                    
    def prove(self,formulas,x):
        print('*'*65)
        x = self.genFormula(x)
        formulas =[self.genFormula(i) for i in formulas]
        print('证明: {{{}}} |- {}'.format(', '.join([str(i) for i in formulas]),x))

        #演绎定理　　syllogism
        origin = x
        pairs = x.getPairs()
        if pairs:
            formulas += [i[0] for i in pairs]
            x = pairs[-1].suf
            print('由演绎定理,即证  {{{}}} |- {} '.format(', '.join([str(i) for i in formulas]),x))

        mp={i:([],'假定') for i in formulas}
        self.addTheo(mp.keys(),mp)  # get some theorem

        # MP  modus ponous
        p = L.mpDeduce(formulas,x,mp)
        
        if p is None:
            #反证,归谬
            s,prv1,prv2 = self.nonDeduce(formulas,x,mp)
            if s is None:
                print("Sorry! I can't prove this proposition. Maybe it's unprovale ")
            else:
                print(s)
                print('证明(1)')
                self.display(prv1)
                print('证明(2)')
                self.display(prv2) 
        else:self.display(p)
        print('*'*65)
        print('\n\n')
            
    def display(self,props):
        for i,(f,wds)  in enumerate(props):
            print('[{}]: {}{explan}'.format(i+1,str(f).ljust(50,'-'),explan= wds))
    
def random_prop(prop = formula([sympy.Symbol('p')]),\
    symbols=sympy.symbols('p q r s t'),n=10):
    fs = [formula([i]) for i in symbols]
    def addLevel(p,sig):
        if sig==0:
            return non(p)
        else:
            cur = fs[randint(0,len(fs)-1)]
            if randint(0,1)==0:return contain(cur,p)
            else:return contain(p,cur)
    for i in range(10):
        prop=addLevel(prop,randint(0,1))
    return prop


if __name__=='__main__':
    L = system_L()
    props=[('((x1>(x2>x3))>(x1> x2)) ->((x1>(x2>x3))->(x1>x3))',[]),
            ('(~(x1>x3)>x1)',[]),
           ('p->r',['p->q','~(q->r)->~p']),
           ('p>(~q>~(p>q))',[]),
           ('p>q>p>p',[]),
           ('~p>p>p',[]),
           ('~(p>q)>~q',[]),
           ('~(p>q)>~q',[]),
           ]
    for prop,garma in props:
        try:
            L.prove(garma,prop)
        except IndexError as e:
            print(garma,prop)
            print('Error! invalid propositions')
        except Exception as e:
            print(e)

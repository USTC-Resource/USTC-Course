# notice that  creating   a class's omstamce won't conflict with __call__ method 
# because the former  call class ,and the latter  call instance
class polynomial:
    pls= []
    n = 0
    def dictize(pl):
        if isinstance(pl,int) or isinstance(pl,float):
            pl = {0:pl}
        if isinstance(pl,polynomial):
            pl = pl.polynomial.copy()
        return pl
    def isZero(n):
        return abs(n)<0.000001
    def __init__(self,s='0 0'):
        polynomial.pls.append(self)
        polynomial.n +=1
        if isinstance(s,polynomial):
            self.polynomial=s.polynomial.copy()
            # don't write like this .**self.polynomial = s.polynomial**,it's ref   
            return
        elif isinstance(s,dict):
            self.polynomial = s.copy()
            return
        s= s.replace(',',' ')
        s= s.replace('x',' ')
        s= s.replace('x^',' ')
        s = s.replace(':',' ')
        s = s.replace('\n',' ')
        s = s.split(' ')
        num = len(s)
        i = 0
        print(s)
        self.polynomial = dict()
        li = [float(i) for i in s]
        while i<num:
            if not polynomial.isZero(li[i]):
                index = li[i+1]
                if index in self.polynomial.keys():
                    self.polynomial[index] += li[i]
                else:self.polynomial[index] = li[i]
            i+=2
        if not self.polynomial:
            self.polynomial = {0:0}
    def __iter__(self):
        return iter(list(self.polynomial.keys()))
    def __getitem__(self,key):
        return self.polynomial[key]
    def __setitem__(self,key,val):
        self.polynomial[key] = val
    def __delitem__(self,k):
        del self.polynomial[k]
    def __add__(self,pl):
        pl = polynomial.dictize(pl)
        rst = self.polynomial.copy()
        for i in pl:
            if i not in rst:
                rst[i] = pl[i]
            else:
                rst[i] += pl[i]
                if polynomial.isZero(rst[i]):
                    del rst[i]
        return polynomial(rst)
    def __iadd__(self,pl):
        pl = polynomial.dictize(pl)
        for i in pl:
            if i not in self:
                self[i] = pl[i]
            else:
                self[i] += pl[i]
                if polynomial.isZero(self[i]):
                    del self[i]
        return self
    def __sub__(self,pl):
        pl = polynomial.dictize(pl)
        tmp = {i:-j for i,j in pl.items()}
        return self + tmp
    def __mul__(self,pl):
        pl = polynomial.dictize(pl)
        dic = dict()
        for i in pl:
            for j in self:
                index= i+j
                if index in dic:
                    dic[index] += pl[i]*self[j]
                else:dic[index] = pl[i]*self[j]
        return polynomial({i:j for i,j in dic.items() if not polynomial.isZero(j)})
    def __imul__(self,pl):
        self = self*pl
        return self
    def __pow__(self,n):
        rst = polynomial({0:1})
        for i in range(n):
            rst*=self.polynomial
        return rst
    def __repr__(self):
        return self.__str__()
    def __str__(self):
        output = ''
        if self.polynomial:
            key = sorted(self.polynomial.keys(),reverse = True)
            num = len(key)
            for j,i in enumerate(key):
                if polynomial.isZero(i):
                    output +='%+g'%self[i]
                    continue
                if not polynomial.isZero(self[i]-1):
                    if not polynomial.isZero(self[i]+1):
                        output +="%+g"%self[i]
                    else:output +='-'
                else:output +='+'
                if not polynomial.isZero(i): output +='x'
                if not polynomial.isZero(i-1):output +='^%g'%i
        
        if output[0] == '+':
            return output[1:]
        return output
    def iterPolynomial(self,s):
        rst = polynomial({0:0})
        for i in self:
            rst += s**int(i)*self[i]
        return rst
    def __call__(self,s):
        if isinstance(s,polynomial):
            return  self.iterPolynomial(s)
        sum = 0
        for i in self:
            sum += self[i] * s**i
        return sum
    def __xor__(self,n):
        tmp = polynomial(self)
        for i in range(n):
            self = self.iterPolynomial(tmp)
        return self
    def save(self):
        polynomial.pls.append(self)
        polynomial.n +=1
    def delPlynomial(self,n):
        return polynomial.pls.pop(n-1)
def menu():
    print('polynomial operations')
    print('1.create')
    print('2.add')
    print('3.sub')
    print('4.iadd')
    print('5.mul')
    print('6.del')
    print('7.display')
    print('8.cal val')
    print('9.polynomial iter')
    print('10.menu')
    primt('11.exit')

def go():
    menu()
    
if __name__ = '__main__':

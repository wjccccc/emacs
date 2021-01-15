#/usr/bin/python
def add(a, b):
    return a+b
#equals to print add(4, 3)

def one(a,*b):
    print(b),type(b)
one(1,2,3,4,5,6)

def two(a=1,**b):
    print(b),type(b)
two(x1=1,b=2,c=3,d=4,e=5,f=6)


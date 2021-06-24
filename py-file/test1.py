#!/usr/bin/python
# coding:utf-8

# class JustCounter:
#     __secretCount = 0
#     publicCount = 0
#     def count(self):
#         self.__secretCount += 1
#         self.publicCount += 1
#         print self.__secretCount
#     def count2(self):
#         print self.__secretCount

# counter = JustCounter()
# counter.count()
# counter.count()
# try:
#     counter.count2()
# except IOError:
#     print "不能调用非公有属性"
# else:
#     print "ok"

# print '-----------简单的赋值-----------'
# shoplist = ['apple','mango','carrot','banana']


# print '完整切片是真正的复制：'

# mylist = shoplist[:]

# del mylist[0]

# print 'shoplist 列表：',shoplist
# print 'mylist 列表：',mylist


# class Cat:

#     def __init__(self,new_name,new_age):
#         self.name = new_name
#         self.age = new_age
#     def __str__(self):
#         return "名字是:%s,年龄是:%d" % (self.name,self.age)

#     def eat(self):
#         print ("%s在吃鱼..." % self.name)

#     def drink(self):
#         print ("%s在喝饮料..." % self.name)


import re
phone = "2004-959-559 # 这是一个国外电话号码"
 
# # 删除字符串中的 Python注释
# print phone
# num = re.sub(r'\D', "", phone)
# print "电话号码是: ", num    

# def chx(matched):
#     print(matched.group(1))
# re.sub('(?P<value>\d+-?)',chx,phone)
def fun(x):
    print(x)
a = "123asd213"

re.sub(r'\d',lambda matched:fun(matched),a)

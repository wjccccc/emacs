#!/usr/bin/python
# coding:utf-8
import os;

document = open("ccc.txt", "w+");

print "文件名: ", document.name;
document.write("这是我创建的第一个测试文件！\nwelcome!");
print document.tell();
#输出当前指针位置

document.write("\n22222!");
print document.tell();

document.write('''
333333
444444
55555
6666
''');
print document.tell();

document.seek(24,os.SEEK_SET);
print document.tell()



context = document.read();
print context;
document.close();

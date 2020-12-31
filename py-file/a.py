
#/usr/bin/python
import time


localtime = time.localtime(time.time())

 
import calendar
 
cal = calendar.month(2016, 1)
print "以下输出2016年1月份的日历:"
print cal
print localtime
print time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

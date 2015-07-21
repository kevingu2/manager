from datetime import datetime, timedelta
import xlrd
import sys
from datetime import datetime

#file1 is new, file2 is old
args = sys.argv
file1 = args[1]
file2 = args[2]

book = xlrd.open_workbook(filename=file1)
sheet = book.sheet_by_name('Admin')

date = sheet.cell_value(1,12)
datetime_value = datetime(*xlrd.xldate_as_tuple(date, 0))
date1 = datetime_value.date()

book = xlrd.open_workbook(filename=file2)
sheet = book.sheet_by_name('Admin')
date = sheet.cell_value(1,12)
datetime_value = datetime(*xlrd.xldate_as_tuple(date, 0))
date2 = datetime_value.date()

if (date2 - date1).days > 0: print "old"
else: print "new"

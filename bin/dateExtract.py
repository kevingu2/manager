import sys
from editpyxl import Workbook
#file1 is new, file2 is old
args = sys.argv
file1 = args[1]
file2 = args[2]
wb = Workbook()
############file1################
wb.open(file1)
ws = wb.get_sheet_by_name('Admin')
date1 = ws.cell('M2').value
#############file2###############
wb.open(file2)
ws = wb.get_sheet_by_name('Admin')
date2 = ws.cell('M2').value

if date2 > date1 : print "old"
else: print "new"

import sys
from editpyxl import Workbook
import ast
########################USAGE################
# python cellEditor.py [filename] [[row1, column1, 123], ..., [row2, column2, 456]]
#############################################
args = sys.argv
wb = Workbook()
fileName = args[1]
strs = args[2]
wb.open(fileName)
ws = wb.active
data = [[i for i in x.strip(" []").split(",")] for x in strs.strip('[]').split("],")]
for d in data:
    row = d[0]
    col = d[1]
    value = d[2]
    ws.cell(col+row).value = value
wb.save(fileName)

import xlrd
import sys
from editpyxl import Workbook
import ast
from openpyxl import load_workbook

def findRows(fileName, ids):
    wb = load_workbook(filename=fileName, read_only = True)
    ws = wb['PipelineView']
    count = 1
    rows = []
    for row in ws.rows:
        if row[0].value in ids:
            rows.append(count)
        count += 1
    return rows

#
# ids = ['AUIA-HFA4A', 'AUIA-HGZ3G', 'AUIA-HHBUO']
# findRows('b.xlsm', ids)
args = sys.argv
wb = Workbook()
fileName = args[1]
strs = args[2]
strs = strs.split()
wb.open(fileName)
ws = wb.active

######find the rows#########
rows = []
cols = []
changes = []
for s in strs:
    rows.append(s[0])
    cols.append(s[1])
    changes.append(s[2])
rows = findRows(fileName, rows)

#######edit cells#########
for i in range(len(rows)): # for all of the changes
    ws.cell(cols[i] + rows[i]).value = changes[i]
wb.save(fileName)

import xlrd
import sys
from editpyxl import Workbook
import ast
from openpyxl import load_workbook
import json
######################USAGE######################
# python cellEditor.py [fileName] "[['id', 'columnName', 'dataToChange'], ..., ['id1', 'columnName1', 'dataToChange1']]"
#                                   list of list, in string format
#################################################
def findRows(fileName, ids):
    wb = load_workbook(filename=fileName, read_only = True)
    ws = wb['PipelineView']
    count = 1
    rows = []
    for row in ws.rows: # search through all rows for the unique ID
        if row[0].value in ids:
            rows.append(count) # keep count of the row number that matches
        count += 1
    return rows

def findCols(cols):
    # can only edit certain columns. if more are needed, add to this dictionary
    column_hash = {'slDir': 'CZ', 'slArch': 'DA', 'leadEstim': 'DB', 'engaged': 'DL', 'solution r/y/g': 'DM', 'estimate': 'DN', 'slComments': 'DO'}
    columns = []
    for c in cols:
        columns.append(column_hash[c])
    return columns

args = sys.argv # get command line args
wb = Workbook()
fileName = args[1]
strs = args[2]
data = [[i for i in x.strip(" []").split(", ")] for x in strs.strip('[]').split("],")] # magic

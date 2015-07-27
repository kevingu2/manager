import sys
from openpyxl import load_workbook
from openpyxl import Workbook
######################USAGE######################
# python cellEditor.py [fileName] "[['id', 'columnName', 'dataToChange'], ..., ['id1', 'columnName1', 'dataToChange1']]"
#                                   list of list, in string format
#################################################
def findRows(fileName, ids):
    wb = load_workbook(filename=fileName, read_only = True)
    ws = wb['PipelineView']
    count = 1
    rows = []
    for i in ids:
        count = 1
        for row in ws.rows: # search through all rows for the unique ID
            if row[0].value == i:
                rows.append(count) # keep count of the row number that matches
                break
            count += 1
    return rows

def findCols(cols):
    # can only edit certain columns. if more are needed, add to this dictionary
    column_hash = {'slDir': 'CZ', 'slArch': 'DA', 'leadEstim': 'DB', 'engaged': 'DL', 'solution': 'DM', 'estimate': 'DN', 'slComments': 'DO'}
    columns = []
    for c in cols:
        columns.append(column_hash[c])
    return columns

args = sys.argv # get command line args
fileName = args[1]
strs = args[2]
data = [[i for i in x.strip(" []").split(", ")] for x in strs.strip('[]').split("],")] # magic
wb = load_workbook(filename = fileName, keep_vba=True)
ws = wb.get_sheet_by_name('PipelineView')
#####get the rows/cols/valuesToChange#########
ids = []
cols = []
changes = []
for d in data:
    ids.append(d[0].strip('\''))
    cols.append(d[1].strip('\''))
    changes.append(d[2].strip('\''))
rows = findRows(fileName, ids)
cols = findCols(cols)
#print len(cols), len(rows)
for c in range(len(changes)): # make the changes
    ws[str(cols[c]) + str(rows[c])]= changes[c]
    print "changed: " + str(cols[c]) + str(rows[c])
wb.save(fileName)

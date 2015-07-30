import sys
from openpyxl import load_workbook
import pickle

args = sys.argv
fileName = args[1]

wb = load_workbook(filename = fileName, read_only=True, keep_vba = True, use_iterators=True)
ws = wb.get_sheet_by_name('PipelineView')
dictionary = {}
for row in ws.rows:
    for cell in row:
        if cell.value != None:
            dictionary[cell.coordinate] = cell.value
pickle.dump(dictionary, open('excelValues', 'wb'))

import sys
from editpyxl import Workbook

args = sys.argv # get args from command line
wb = Workbook()
fileName = args[1]
row = args[2]
data = args[3]
source_filename = fileName
result_filename = r'result.xlsm'
wb.open(source_filename)
ws = wb.active

for d in data: # changes each value one cell at a time
    ws.cell(d+row).value = data[d]

wb.save(result_filename)
#wb.close() can't close because the library never closes a passed in filename. EVER

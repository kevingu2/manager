import xlrd as excel
from collections import OrderedDict
import simplejson as json

def openFile(path):
  workBook = excel.open_workbook(path) #open file
  workSheet = workBook.sheet_by_name('PipelineView') # convert to spreadsheet
  info = [] # lists of dictionaries
  row_content = {}
  list_of_cols = []
  for cols in range(workSheet.ncols):
    list_of_cols.append(workSheet.cell_value(0, cols))

  for rows in range(workSheet.nrows):
      for cols in range(workSheet.ncols):
        row_content[list_of_cols[cols]] = workSheet.cell_value(rows,cols)

  info.append(row_content)
  return info

data = []
data = openFile('BD-PipelineViewer8 13 April.xlsm')

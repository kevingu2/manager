import xlrd
from xlrd import open_workbook
from xlutils.copy import copy
from collections import OrderedDict
import simplejson as json
import xlsxwriter
import xlwt
import xlutils.copy
import sys

def openFile(path):
  workBook = open_workbook(path) #open file
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

args = sys.argv # command line arguments
data = []
data = openFile(args[1])

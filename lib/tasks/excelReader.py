import xlrd
from xlrd import open_workbook
from xlutils.copy import copy
from collections import OrderedDict
import simplejson as json
import xlsxwriter
import xlwt
import xlutils.copy
import sys
import datetime
import collections
import json
########################################
# USAGE: python excelReader.py file.xlsm
########################################
def openFile(path):
  workBook = open_workbook(path) #open file
  workSheet = workBook.sheet_by_name('PipelineView') # convert to spreadsheet
  info = [] # lists of dictionaries
  row_content = {}
  list_of_cols = []
  date_format = xlwt.XFStyle() # used to extract the dateformat in excel (it's stupid)
  date_format.num_format_str = 'dd/mm/yyyy'
  for cols in range(workSheet.ncols): # column names are stored in row 0, this gets all of them
    list_of_cols.append(workSheet.cell_value(0, cols))

  rowCount = 1 # start at row 1
  for rows in range(workSheet.nrows):
      #info = []
    row_content = {}
    row_content['coordinate'] = rowCount # coordinate is the cell coordinator, A1
    rowCount += 1
    for cols in range(workSheet.ncols):
        test = 0
        value = workSheet.cell_value(rows,cols)
        if list_of_cols[cols] == value:
            continue
        if not isinstance(value, float): # if it's not a float, encode to get rid of u'text
            value = value.encode('utf8')
        row_content[list_of_cols[cols].encode('utf8')] = value
        ###############excel date conversion to string##############
        # because excel stores dates as floats, need to convert to datetime
        # and then convert that into a string
        # if list_of_cols[cols] == "RFPDate": # need to expand for other columns
        #     date = row_content['RFPDate']
        #     if date != 'RFPDate': # ignore first column which is just RFPDate itself
        #         newDate = datetime.datetime(*xlrd.xldate_as_tuple(date, workBook.datemode)) # conert to datetime
        #         date = newDate.strftime('%d/%m/%Y') #convert to string
        #         #print(newDate.strftime('%d/%m/%y'))
        #         row_content['RFPDate'] = date
    info.append(row_content.copy())
  return info

args = sys.argv # command line arguments
data = []
data = openFile(args[1])
data = data[1:] # throw away row 0
print json.dumps(data, ensure_ascii=True)

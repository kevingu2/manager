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
########################################
# USAGE: python excelReader.py file.xlsm
########################################
def openFile(path):
  workBook = open_workbook(path) #open file
  workSheet = workBook.sheet_by_name('PipelineView') # convert to spreadsheet
  info = [] # lists of dictionaries
  row_content = {}
  list_of_cols = []
  date_format = xlwt.XFStyle()
  date_format.num_format_str = 'dd/mm/yyyy'
  for cols in range(workSheet.ncols):
    list_of_cols.append(workSheet.cell_value(0, cols))

  for rows in range(workSheet.nrows):
      for cols in range(workSheet.ncols):
        test = 0
        row_content[list_of_cols[cols]] = workSheet.cell_value(rows,cols)

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
#data = openFile(args[1])
data = openFile('BD-PipelineViewer8 13 April.xlsm')

def maxValue(data):
    return max(data)

def avgValue(data):
    return sum(data) / len(data)

def lowValue(data):
    return min(data)

def getColumn(data, columnName):
    list = []
    for d in data:
        if columnName in d:
            if d[columnName] != columnName:
                list.append(d[columnName])
    return list

####################################################
# example usage of how to get statistics
# print maxValue(getColumn(data, 'Total Value $M'))
####################################################

#print(data) # print for kevin :D
#below is stuff to make graph for RFPDate
#import pickle
#pickle.dump(rfp, open("graph.json", "wb"))

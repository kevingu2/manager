######################################################################

#TO DO:
# FIX:
#   the date format
#   search by keywords that aren't strings

#####################################################################


'''
excelToCSV.py
This file converts an excel file to a csv file
07/01/2015
'''

import xlrd as excel
import csv
import numpy as np

def csvFromExcel(path):
  #opening the excel file
  workbook = excel.open_workbook(path)
  #using PipelineView sheet
  sheet = workbook.sheet_by_name('PipelineView')
  #openning the csv file to move/write the data from excel to csv file
  csv_file = open('myCSVFile.csv', 'w')
  write_data = csv.writer(csv_file, quoting = csv.QUOTE_ALL)

  #write all the rows into the csv file
  for rownum in xrange(sheet.nrows):
    write_data.writerow(sheet.row_values(rownum))
  
  '''
  #saving all the data in a list of dictionaries
  row_content = {}
  info = []
  for rows in range(sheet.nrows):
    for cols in range(sheet.ncols):
      row_content[list_of_cols[cols]] = sheet.cell_value(rows,cols)
    info.append(row_content)
  '''
  #closing the csv file to limit damages to the file
  csv_file.close()
  #returning the csv file
  return csv_file

#saving the names of all columns in a list
def find_list(path):
  #openning the excel file
  workbook = excel.open_workbook(path)
  #using PipelineView sheet
  sheet = workbook.sheet_by_name('PipelineView')
  #list of the name of all columns
  list_of_cols = []
  #getting the first row's data which is the name of the columns
  for cols in range(sheet.ncols):
    list_of_cols.append(sheet.cell_value(0,cols))
  #returning the list
  return list_of_cols

#searching by a keyword
def search_by_keyword(keyword, csv_file):
  #openning the csv file
  with open('myCSVFile.csv', 'rb') as csvFile:
    #get the content
    content = csv.reader(csvFile, delimiter=',')
    #searching for the keyword in csv file
    for row in content:
      #if the keyword is found, return the data for that row
      if keyword in row:
        return row
    #if the keyword is not found, print out an error
    print str(keyword) + " not found!"      


#def update_data(csv_file, list_of_cols):
#  new_csv_file = open(csv_file, 'wb')
#  list_of_cols = np.loadtext(csv_file)
  

file = csvFromExcel( "/Users/sarafarsi/Desktop/SAIC/data.xlsx")
print search_by_keyword('Alice', file)
print search_by_keyword(101, file)
print search_by_keyword('we', file)

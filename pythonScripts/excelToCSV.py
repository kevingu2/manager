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
  #using sheet index 1 (second sheet in this case)
  sheet = workbook.sheet_by_index(1)

  #list of the name of all columns
  list_of_cols = []
  #getting the first row's data which is the name of the columns
  for cols in range(sheet.ncols):
    list_of_cols.append(sheet.cell_value(0,cols))
  
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
  #returning the list of the names of the columns to access the data in other
  #methods
  return list_of_cols

#def update_data(csv_file, list_of_cols, position):
#  list_of_cols = np.loadtext(csv_file)


csvFromExcel( "/Users/sarafarsi/Desktop/SAIC/data.xlsx")

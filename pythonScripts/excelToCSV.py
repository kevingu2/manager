



import xlrd as excel
import csv
import numpy as np

def csvFromExcel(path):
  workbook = excel.open_workbook(path)
  sheet = workbook.sheet_by_index(0)

  #list of the name of all columns
  list_of_cols = []
  for cols in range(sheet.ncols):
    list_of_cols.append(sheet.cell_value(0,cols))

  csv_file = open('myCSVFile.csv', 'w')
  write_data = csv.writer(csv_file, quoting = csv.QUOTE_ALL)

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

  csv_file.close()
  return list_of_cols

'''
def update_data(csv_file, list_of_cols, position):
  list_of_cols = np.loadtext(csv_file)
'''  





csvFromExcel( "/Users/sarafarsi/Desktop/SAIC/data.xlsx")

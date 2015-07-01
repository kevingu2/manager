from xlrd import open_workbook
from xlwt import Workbook
from xlutils.copy import copy
from xlutils.view import View


def edit(fileName, row, column, data):
    rb = open_workbook(fileName)
    wb = copy(rb)

    s = wb.get_sheet(0)
    s.write(row, column, data)
    wb.save(fileName)

def print_data(rows):
    for row in rows:
        for value in row:
            print value,
        print

# below is an example of the usage
# edit('abc.xlsm', 3, 2, "abcabcabcabab")
#       fileName, row, column, newData

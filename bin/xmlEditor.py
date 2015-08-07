import re
import sys
import cPickle as pickle
from collections import defaultdict
import os
#############################################
# This file edits the extracted xml files sharedStrings.xml and sheet2.xml
# from the excel file. sharedStrings.xml contains all of the strings in the entire excel file (seriously)
# and sheet2.xml contains a mapping of cell -> string in sharedStrings.xml
#############################################

def findCols(cols):
    # can only edit certain columns. if more are needed, add to this dictionary
    column_hash = {'slDir': 'CZ', 'slArch': 'DA', 'leadEstim': 'DB', 'engaged': 'DL', 'solution': 'DM', 'estimate': 'DN', 'slComments': 'DO'}
    columns = []
    for c in cols:
        columns.append(column_hash[c])
    return columns

# makes the cell we're changing to point to that new string we will make in sharedStrings.xml
def pointSheetToString(coordinate, uniqueCount, sheet, sheetDir):
    regexString = r'r="%s" s="(\d*)" t="(\w*)"><v>(\d*)</v>' % coordinate # my brain hurts from this
    match = re.search(regexString, sheet)

    if match == None: # if the cell is blank, it will not find. this is the backup
        regexString = r'r="%s" s="(\d*)"/>' % coordinate
        match = re.search(regexString, sheet)
        replaceString = "r=\"" + coordinate + "\" s=\"" + match.group(1) + "\" t=\"s\"><v>" + str(uniqueCount) + "</v></c>"
        newSheet = re.sub(regexString, replaceString, sheet) # replace where the cell points to
        index = newSheet.index(coordinate)
    else:
        replaceString = "r=\"" + coordinate + "\" s=\"" + match.group(1) + "\" t=\"" + match.group(2) + "\"><v>" + str(uniqueCount) + "</v>" # this made me cry a little inside
        newSheet = re.sub(regexString, replaceString, sheet)
    f = open(sheetDir, 'wb')
    f.write(newSheet)
    f.close()
    return newSheet

def createNewCellValue(string, sharedStrings, coordinate, sheet, sharedStringsDir, sheetDir): # appends string to the end of sharedStrings.xml and increments the string count
    match = re.search(r'uniqueCount="(\d*)"', sharedStrings) # get the uniqueCount
    oldUniqueCount = int(match.group(1))
    newUniqueCount = oldUniqueCount + 1 # increment it by one
    sheet = pointSheetToString(coordinate, oldUniqueCount, sheet, sheetDir)
    sharedStrings = sharedStrings.replace(str(oldUniqueCount), str(newUniqueCount)) # replace it with the new count
    newSharedStrings = sharedStrings[:sharedStrings.index('</sst>')] + '<si><t>' + string + '</t></si>' + sharedStrings[sharedStrings.index('</sst>'):]
    f = open(sharedStringsDir, 'wb')
    f.write(newSharedStrings)
    f.close
    return newSharedStrings, sheet # pass the value so we don't have to read the file again

args = sys.argv
sharedStringsDir = args[1]
sheetDir = args[2]
strs = args[3]
# open file and find all of the input strings
sharedStrings = open(sharedStringsDir, 'r').read()
sheet = open(sheetDir).read() # this is the PipelineView sheet
excelValues = pickle.load(open('public/uploads/data/coordinateToValue', 'rb')) # load dictionary of {cellCoordinate : cellValue}

data = [[i for i in x.strip(" []").split(", ")] for x in strs.strip('[]').split("],")] # magic
#####get the rows/cols/valuesToChange#########
rows = []
cols = []
changes = []
columns = []
for d in data: # parses the data passed in, so we know what/where to change
    rows.append(d[0].strip('\''))
    cols.append(d[1].strip('\''))
    changes.append(d[2].strip('\''))

cols = findCols(cols)
coordinates = []
for index in range(len(cols)):
    coordinates.append(cols[index] + str(rows[index]))
for index in range(len(coordinates)):
    sharedStrings,sheet = createNewCellValue(changes[index], sharedStrings, coordinates[index], sheet, sharedStringsDir, sheetDir)

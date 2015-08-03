import re
import sys
import cPickle as pickle
from collections import defaultdict
import os
def findCols(cols):
    # can only edit certain columns. if more are needed, add to this dictionary
    column_hash = {'slDir': 'CZ', 'slArch': 'DA', 'leadEstim': 'DB', 'engaged': 'DL', 'solution': 'DM', 'estimate': 'DN', 'slComments': 'DO'}
    columns = []
    for c in cols:
        columns.append(column_hash[c])
    return columns

def findStringMatch(string, stringMatches):
    index = 0
    for s in stringMatches:
        if s.replace('&amp;', '&') == string: # stupid xml uses &amp; instead of just &
            return index
        index += 1

def isOnlyReference(string, cellMatches):
    print cellMatches[string]

def pointSheetToString(coordinate, uniqueCount, sheet, sheetDir):
    regexString = r'r="%s" s="(\d*)" t="(\w*)"><v>(\d*)</v>' % coordinate # my brain hurts from this
    match = re.search(regexString, sheet)

    if match == None: # if the cell is blank, it will not find. this is the backup
        regexString = r'r="%s" s="(\d*)"/>' % coordinate
        match = re.search(regexString, sheet)
        print "*"*30,match.group(1)
        replaceString = "r=\"" + coordinate + "\" s=\"" + match.group(1) + "\" t=\"s\"><v>" + str(uniqueCount) + "</v></c>"
        newSheet = re.sub(regexString, replaceString, sheet)
        index = newSheet.index(coordinate)
        print newSheet[index-20:index+100]
        # print "failed to find match for: " + coordinate, uniqueCount
        #TODO!!!!!!!!!!!!!!!
    else:
        replaceString = "r=\"" + coordinate + "\" s=\"" + match.group(1) + "\" t=\"" + match.group(2) + "\"><v>" + str(uniqueCount) + "</v>" # this made me cry a little inside
        newSheet = re.sub(regexString, replaceString, sheet)
        print uniqueCount
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
    return newSharedStrings, sheet

args = sys.argv
sharedStringsDir = args[1]
sheetDir = args[2]
strs = args[3]
# open file and find all of the input strings
sharedStrings = open(sharedStringsDir, 'r').read()
sheet = open(sheetDir).read() # this is the PipelineView sheet
excelValues = pickle.load(open('public/uploads/data/coordinateToValue', 'rb')) # load dictionary of {cellCoordinate : cellValue}

# get all of the pairs in the files
matches = tuple(re.finditer(r'<t>(.*)</t>', sharedStrings, re.M|re.I))
stringMatches = [m.group(1) for m in matches]#current groups are [<t>] [whatwewant] [</t>], this keeps only what we want


# matches = tuple(re.finditer(r'<c r="(.*)" s="\d*" t="(.*)">\s*<v>(.*)</v>', sheet, re.M|re.I)) # magical regex I wrote. Seriously
# cellMatches = {}
# for m in matches:
#     cellMatches[m.group(1)] = m.group(3) # group 1 is the cell, group 3 is the corresponding sharedStrings number


data = [[i for i in x.strip(" []").split(", ")] for x in strs.strip('[]').split("],")] # magic
#####get the rows/cols/valuesToChange#########
rows = []
cols = []
changes = []
columns = []
for d in data:
    rows.append(d[0].strip('\''))
    cols.append(d[1].strip('\''))
    changes.append(d[2].strip('\'').replace('&', '&amp;'))

cols = findCols(cols)
coordinates = []
for index in range(len(cols)):
    coordinates.append(cols[index] + str(rows[index]))
for index in range(len(coordinates)):
    sharedStrings,sheet = createNewCellValue(changes[index], sharedStrings, coordinates[index], sheet, sharedStringsDir, sheetDir)

import re
import sys
import cPickle as pickle
from collections import defaultdict

def findStringMatch(string, stringMatches):
    index = 0
    for s in stringMatches:
        if s.replace('&amp;', '&') == string: # stupid xml uses &amp; instead of just &
            return index
        index += 1

def isOnlyReference(string, cellMatches):
    print cellMatches[string]

def pointSheetToString(coordinate, uniqueCount, sheet):
    regexString = r'r="%s" s="(\d*)" t="(\w*)"><v>(\d*)</v>' % coordinate # my brain hurts from this
    match = re.search(regexString, sheet)
    replaceString = "r=\"" + coordinate + "\" s=\"" + match.group(1) + "\" t=\"" + match.group(2) + "\">\n  <v>" + str(uniqueCount) + "</v>" # this made me cry a little inside
    newSheet = re.sub(regexString, replaceString, sheet)
    f = open('xl/worksheets/sheet2.xml', 'wb')
    f.write(newSheet)
    f.close()

def createNewCellValue(string, sharedStrings, coordinate, sheet): # appends string to the end of sharedStrings.xml and increments the string count
    match = re.search(r'uniqueCount="(\d*)"', sharedStrings) # get the uniqueCount
    oldUniqueCount = int(match.group(1))
    newUniqueCount = oldUniqueCount + 1 # increment it by one
    pointSheetToString(coordinate, oldUniqueCount, sheet)
    sharedStrings = sharedStrings.replace(str(oldUniqueCount), str(newUniqueCount)) # replace it with the new count
    newSharedStrings = sharedStrings[:sharedStrings.index('</sst>')] + '  <si>\n  <t>' + string + '</t>\n  </si>\n' + sharedStrings[sharedStrings.index('</sst>'):]
    f = open('xl/sharedStrings.xml', 'wb')
    f.write(newSharedStrings)
    f.close()

# open file and find all of the input strings
sharedStrings = open('xl/sharedStrings.xml', 'r').read()
sheet = open('xl/worksheets/sheet2.xml').read() # this is the PipelineView sheet
excelValues = pickle.load(open('coordinateToValue', 'rb')) # load dictionary of {cellCoordinate : cellValue}

# get all of the pairs in the files
matches = tuple(re.finditer(r'<t>(.*)</t>', sharedStrings, re.M|re.I))
stringMatches = [m.group(1) for m in matches]#current groups are [<t>] [whatwewant] [</t>], this keeps only what we want


matches = tuple(re.finditer(r'<c r="(.*)" s="\d*" t="(.*)">\s*<v>(.*)</v>', sheet, re.M|re.I)) # magical regex I wrote. Seriously
cellMatches = {}
for m in matches:
    cellMatches[m.group(1)] = m.group(3) # group 1 is the cell, group 3 is the corresponding sharedStrings number

cellValue = 'B2'

#pointSheetToString(cellValue, 3050, sheet)
createNewCellValue("test", sharedStrings, cellValue, sheet)

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
# open file and find all of the input strings
sharedStrings = open('xl/sharedStrings.xml', 'r').read()
sheet2 = open('xl/worksheets/sheet2.xml').read() # this is the PipelineView sheet
excelValues = pickle.load(open('excelValues', 'rb')) # load dictionary of {cellCoordinate : cellValue}

# get all of the pairs in the files
matches = tuple(re.finditer(r'<t>(.*)</t>', sharedStrings, re.M|re.I))
stringMatches = [m.group(1) for m in matches]#current groups are [<t>] [whatwewant] [</t>], this keeps only what we want


matches = tuple(re.finditer(r'<c r="(.*)" s="\d*" t="(.*)">\s*<v>(.*)</v>', sheet2, re.M|re.I)) # magical regex I wrote. Seriously
cellMatches = {}
for m in matches:
    cellMatches[m.group(1)] = m.group(3) # group 1 is the cell, group 3 is the corresponding sharedStrings number

cellValue = 'DL4'
if cellValue in excelValues.keys():
    findString = excelValues[cellValue]
    foundString = findStringMatch(findString.encode('ascii', 'ignore'), stringMatches)
    print stringMatches[foundString]
else:
    print "empty cell"

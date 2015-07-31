import zipfile
import sys
import os

args = sys.argv
excelFile = args[1]
sharedStringsDir = args[2]
sheetDir = args[3]

#rename .xlsm to .zip
zipFileName = excelFileName.replace('.xlsm', 'zip')
os.rename(excelFileName, zipFileName)

# add the files to the zip file
z = zipfile.ZipFile(excelFileName, "a") # a for append
z.write(sharedStringsDir)
z.write(sheetDir)
z.close()

#rename zip file back to excel
os.rename(zipFileName, excelFileName)

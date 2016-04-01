import tempfile
import zipfile
from shutil import move, rmtree
import os
import sys

# takes a zip, removes all the files in filenames
def remove_from_zip(zipfname, *filenames):
    tempdir = tempfile.mkdtemp()
    try:
        tempname = os.path.join(tempdir, 'new.zip')
        with zipfile.ZipFile(zipfname, 'r') as zipread:
            with zipfile.ZipFile(tempname, 'w') as zipwrite:
                for item in zipread.infolist():
                    if item.filename not in filenames:
                        data = zipread.read(item.filename)
                        zipwrite.writestr(item, data)
        move(tempname, zipfname)
    finally:
        rmtree(tempdir)

args = sys.argv
excelFileName = args[1]
sharedStringsDir = args[2]
sheetDir = args[3]
sharedStringName = sharedStringsDir.replace('public/uploads/data/', '')
sheetName = sheetDir.replace('public/uploads/data/', '')
#rename .xlsm to .zip
zipFileName = excelFileName.replace('.xlsm', '.zip')
move(excelFileName, zipFileName)

#remove the two files from the zip
remove_from_zip(zipFileName, 'xl/sharedStrings.xml', 'xl/worksheets/sheet2.xml')
with zipfile.ZipFile(zipFileName, 'a') as z:
    z.writestr(sharedStringName, open(sharedStringsDir).read())
    z.writestr(sheetName, open(sheetDir).read())
    print z.printdir()
    z.close()

move(zipFileName, excelFileName)

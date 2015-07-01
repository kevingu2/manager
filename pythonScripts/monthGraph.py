import pickle
import datetime
import sys

args = sys.argv
graph = pickle.load(open(args[1], "rb"))

# hardcoded because printing a defaultdict is ugly and saves an import
months = {'01':0, '02':0, '03':0, '04':0, '05':0, '06':0, '07':0, '08':0, '09':0, '10':0, '11':0, '12':0}
for date in graph:
    month = date.split('/', 3)
    months[month[0]] += 1

print months # json format of which month has how many instances

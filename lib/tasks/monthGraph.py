import pickle
import datetime
import collections
import sys
import json

args = sys.argv
graph = pickle.load(open(args[1], "rb"))

months = collections.defaultdict(int)
for date in graph:
    month = date.split('/', 3)
    months[month[0]] += 1

print json.dumps(months)

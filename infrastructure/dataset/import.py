import json
import os
import sys
from pprint import pprint

from elasticsearch import Elasticsearch
from elasticsearch import exceptions as expf

es = Elasticsearch( [sys.argv[1]], port=9200 )
db_dir = "dataset/json"

dbs = [files for root, dirs, files in os.walk(db_dir)][0]
print(dbs)
for db in dbs:
  MyFile= open("./" + db_dir + "/" + db,'r').read()
  db_name = db.split(".")[0]
  ClearData = MyFile.splitlines(True)
  i=0
  json_str=""
  docs ={}
  print(db_name)
  for line in ClearData:
    line = ''.join(line.split())
    try:
        es.index(index=db_name, doc_type='entry', id=i, body=line)
    except expf.RequestError as e:
        print(e.info)
        exit(0)
    i=i+1

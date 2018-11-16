import pymongo

myclient = pymongo.MongoClient("mongodb://127.0.0.1:30017/")
mydb = myclient["test"]
mycol = mydb["test"]

myquery = { "a": 1 }

mydoc = mycol.find(myquery)

for x in mydoc:
  print(x)
from pymongo import MongoClient
from django.http import JsonResponse
import random, string
from datetime import datetime
from pytz import timezone

class Database:
    def __init__(self, connection_string, collection_name):
        self.client = MongoClient(connection_string, ssl=True)
        self.database = self.client['redeat']
        self.collection = self.database[collection_name]
        self.counter_collection = self.database['uniqueIdentifier']


class Nutritionix(Database):
    def __init__(self, connection_string):
        super().__init__(connection_string, 'nut')
        
    def insert_data(self, data):
        # query = {"id": "unique"}
        # current_counter = self.counter_collection.find_one(query)
        # count = current_counter['count']
        # new_counter = {'$set': {"count": count + 1}}
        # self.counter_collection.update_one(current_counter, new_counter)
        
        # data['id'] = count
        self.collection.insert_one(data)


if __name__ == '__main__':
    database = Nutritionix('mongodb+srv://redeat:redeat@redeat.nhlgg5q.mongodb.net/?retryWrites=true&w=majority')
    database.insert_data({'hello': 'world'})


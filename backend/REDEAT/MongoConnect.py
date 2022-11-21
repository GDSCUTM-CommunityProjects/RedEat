from pymongo import MongoClient


class Database:
    def __init__(self, connection_string, collection_name):
        self.client = MongoClient(connection_string, ssl=True)
        self.database = self.client['redeat']
        self.collection = self.database[collection_name]
        self.counter_collection = self.database['uniqueIdentifier']


class Nutritionix(Database):
    def __init__(self, connection_string):
        super().__init__(connection_string, 'nutri_info')

    def insert_product_info(self, upc, name, info, hits=0):
        query = {"id": "unique"}
        current_counter = self.counter_collection.find_one(query)
        count = current_counter['count']
        new_counter = {'$set': {"count": count + 1}}
        self.counter_collection.update_one(current_counter, new_counter)

        data = {
            "upc": upc,
            "name": name,
            "info": info,
            "hits": hits,
            "id": count
        }
        self.collection.insert_one(data)

    def get_data(self, upc):
        """
        Query the database for the given upc
        """
        query = {"upc": upc}
        data = self.collection.find_one(query)
        if (data is None) or (data == {}):
            return {}
        else:
            # update the hits
            self.update_hits(upc, data['hits'] + 1)
            del data['_id']
            return data

    def update_hits(self, upc, hits):
        """
        Update the hits of the given upc
        """
        query = {"upc": upc}
        data = {"$set": {"hits": hits}}
        self.collection.update_one(query, data)


if __name__ == '__main__':
    database = Nutritionix('mongodb+srv://redeat:redeat@redeat.nhlgg5q.mongodb.net/?retryWrites=true&w=majority')

    sample_data = {
        "upc": "123456789",
        "name": "sample",
        "info": {
            "calories": 100,
            "fats": 10,
            "fiber": 1
        }
    }

    # database.insert_product_info(sample_data['upc'], sample_data['name'], sample_data['info'])
    print(database.get_data(sample_data['upc']))

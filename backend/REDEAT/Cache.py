from MongoConnect import Nutritionix
import nutritionix_api


def get_product_info(upc: str, name: str):
    """
    get the product info from the database if it exists, otherwise query the
    nutritionix database and insert the data into the database
    """
    database = Nutritionix('mongodb+srv://redeat:redeat@redeat.nhlgg5q.mongodb.net/?retryWrites=true&w=majority')
    has_upc = (upc != "")
    has_name = (name != "")
    
    if has_upc:
        cache = database.get_data(upc)
        if cache != {}:
            return cache
    
    if has_upc and not has_name:
        # upc not in database
        # query nutritionix
        name = nutritionix_api.get_product_name_from_upc(upc)
        
        if (name is None) or (name == ""):
            return {}
        else:
            data = nutritionix_api.get_product_info_from_item_exact_name(name)
            database.insert_product_info(upc, name, data)
            return data
    elif has_name and not has_upc:
        # query nutritionix
        return nutritionix_api.get_product_info_from_item_exact_name(name)
    elif has_upc and has_name:
        data = nutritionix_api.get_product_info_from_item_exact_name(name)
        database.insert_product_info(upc, name, data)
        return data

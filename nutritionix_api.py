import requests

NUTRITIONIX_URL = "https://api.nutritionix.com/v1_1/search"

UPC_DATABASE_URL = "https://www.upcdatabase.com/item/"

APP_ID = "72866909"

APP_KEY = "eb02d44346ea2ff2b17db41349a5ed5a"


def get_product_suggestions_from_name(name: str) -> dict:
    """
    Queries the Nutritionix Database and returns a Dict containing top 5
    suggestions.

    :param name: product name
    :return: "item_name", "brand_name", "item_id" of the products
    """
    header = {"Content-Type": "application/json"}
    data = {"appId": APP_ID,
            "appKey": APP_KEY,
            "query": name,
            "limit": 5,
            "filters": {"item_type": 2},
            "fields": ["item_name", "brand_name", "item_id"]}

    product_info = requests.post(url=NUTRITIONIX_URL, headers=header, json=data)

    print(product_info.json()["hits"])


def get_product_info_from_item_id(item_id: str) -> dict:
    """
    returns all the product info from Nutritionix database given the item_id
    associated with the product
    :param item_id: item_id must exist in the Nutritionix database
    :return: Dict containing product information
    """
    header = {"Content-Type": "application/json"}
    data = {"appId": APP_ID,
            "appKey": APP_KEY,
            "queries": {"item_id": item_id},
            "limit": 5,
            "filters": {"item_type": 2}}

    product_info = requests.post(url=NUTRITIONIX_URL, headers=header, json=data)

    print(product_info.json())


def get_product_name_from_upc(upc: str) -> str:
    """
    Queries the UPC database and returns a product name associated with the
    given UPC.

    :param upc: 12 digit UPC code including leading zeros
    :return: product name associated with UPC. empty string if product not found
    """
    full_page = requests.get(url=UPC_DATABASE_URL + upc).text
    start_index = full_page.find("Description</td><td></td><td>")
    offset = len("Description</td><td></td><td>")
    end_index = full_page[start_index + offset:].find("</td>")

    return full_page[start_index + offset:start_index + len("Description</td><td></td><td>") + end_index]


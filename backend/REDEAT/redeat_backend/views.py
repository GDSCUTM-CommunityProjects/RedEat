import json

from django.contrib.auth.models import User
from django.http import HttpResponse
from django.http import JsonResponse
from rest_framework_simplejwt.backends import TokenBackend
from rest_framework_simplejwt.exceptions import TokenBackendError

import Cache

def account(request):
    """
    End point that serves sign-up request.
    :param request: inbound http request.
    :return: http response.
             200 - User created successfully

    """
    if request.method == "POST":

        # Create new User
        json_data = json.loads(request.body)
        try:
            # trying to unpack required params
            username = json_data['username']
            first_name = json_data['first_name']
            last_name = json_data['last_name']
            email = json_data['email']
            password = json_data['password']
        except KeyError:
            # if any params missing
            return HttpResponse("Malformed Data",
                                status=400)

        if User.objects.filter(username=username).exists():
            return HttpResponse(status=403)

        user = User.objects.create_user(username, email=email,
                                        password=password)

        user.first_name = first_name
        user.last_name = last_name
        user.save()

        return HttpResponse({"Success !"}, status=200)

    elif request.method == "PUT":
        # Update Existing User
        # User has to be authenticated
        pass

    else:
        # Other methods are not supported, return 400 Bad Request
        return HttpResponse(status=400)


def verify(request):
    """
    called to verify if user logged in or nor
    :param request: http request
    :return: 200 if logged in and 401 otherwise
    """

    token = request.META.get('HTTP_AUTHORIZATION', " ").split(' ')[1]
    try:
        TokenBackend(algorithm='HS256').decode(token, verify=False)
        return HttpResponse(status=200)
    except TokenBackendError:
        return HttpResponse(status=401)

def search_product(request):
    """
    called with two parameters upc and product_name to obtain product information.
    pre-condition : The body must contain at least one of the parameters. Empty parameter should be passed as an empty string.
    :param request:
    :return:
    """
    if request.method == "GET":
        json_data = json.loads(request.body)
        try:
            # trying to unpack required params
            upc = json_data['upc']
            product_name = json_data['product_name']
        except KeyError:
            # if any params missing
            return HttpResponse({"Malformed Request"},
                                status=400)

        # call the hidden function here

        product_information = get_data(upc, product_name)
        return JsonResponse(product_information)

        pass
    else:
        # Other methods are not supported, return 400 Bad Request
        return HttpResponse(status=400)


def get_data(upc, product_name):
    """
    Place holder ment to hold place for cacheing function 
    """
    return Cache.get_product_info(upc, product_name)

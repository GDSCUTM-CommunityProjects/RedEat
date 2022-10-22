from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import User
import json

from rest_framework.exceptions import ValidationError
from rest_framework_simplejwt.backends import TokenBackend


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
            return HttpResponse({"message": "Malformed data"},
                                status=400)

        try:
            user = User.objects.create_user(username, email=email,
                                            password=password)
        except:
            return HttpResponse(status=403)

        user.first_name = first_name
        user.last_name = last_name
        user.save()

        return HttpResponse({"message": "Success !"}, status=200)

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
        valid_data = TokenBackend(algorithm='HS256').decode(token, verify=False)

        user = User.objects.get(id=valid_data['user_id'])
        return HttpResponse(status=200)
    except:
        return HttpResponse(status=401)

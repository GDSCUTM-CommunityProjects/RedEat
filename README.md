# RedEat

# REST BACKEND API

The REST API Endpoints for REDEAT app 

## Signup a User

### Request

`POST /api/account/`

    Login required : False
    body: {username, password, first_name, last_name, email}

### Response

    Status:
    200 - User created successfully 
    403 - User alredy exists 
    400 - Malformed data
    404 - Bad request 
    
    body: {}
    
    
## Get Authentication Token

### Request

`POST /api/token/`

    Login required : False
    body:{username,password}

### Response

    Status:
    200 - Token generated successfully 
    401 - User doesnot exist 
    404 - Bad request 
    
    body: Error Message
    
## Verify Token

### Request

`POST /api/verify/`

    Login required : True
    body:{}

### Response

    Status:
    200 - Token Verified 
    401 - Unauthorised Token
    
    body: {}
    
    
 

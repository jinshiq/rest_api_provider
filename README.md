#README

####Environment

Ruby version: 2.2.4

Rails version: 4.2.5.1


##Overview

This is a simple application to show how to create a <b>REST API</b> in Rails. Via this API, you can create, read, update and delete data and files. 

This application creates two APIs, one for <b>User</b> model and the other for <b>Photo</b> model. 
User model has text fields only and is designed to require no API authentication for API access, 
while Photo model contains file field and is designed to require API authentication.

It uses <b>'jbuilder'</b> gem to generate Json data , uses <b>'paperclip'</b> gem to upload images to <b>AWS</b> cloud, and
uses <b>'figaro'</b> gem to hide sensitive information such as <b>AWS_ACCESS_KEY_ID</b> and <b>AWS_SECRET_ACCESS_KEY</b>
when accessing third-party's API.   

When a new user is created or a new photo is uploaded, <b>Ajax</b> technology is used for the list page update.


##API Key Generation

User model has a column called <b>'api_key'</b>. The application will automatically generate a unique <b>api_key</b> 
when a new user is created, using below method.

```ruby
def generate_api_key
  loop do
    token = SecureRandom.base64.tr('+/=', 'Qrt')
	break token unless User.exists?(api_key: token)
  end
end
```


##API Authentication

We use the inbuilt rails method <b>authenticate_with_http_token</b> for API authentication. 

The authentication code is only added to the class that is required for API authentication, 
for example <b>Photo</b> class in our case, but not <b>User</b> class.


##Call REST_API

<b>1. Use curl</b>

If API authenticaion is not requred, e.g. <b>User</b> api in our case, use commands like below.

```ruby
$curl http://localhost:3000/users.json
$curl http://localhost:3000/users/1.json
```

If API authenticaion is requred, e.g. <b>Photo</b> api in our case,  use commands like below.

```ruby
$curl -H "Authoriation: Token token=22XRYWnwHdMrYthba1PbtAtt" http://localhost:3000/api/v1/photos.json
$curl -H "Authoriation: Token token=22XRYWnwHdMrYthba1PbtAtt" http://localhost:3000/api/v1/photos/1.json
```

<b>2. Use browser</b>

If API authenticaion is not requred, e.g. <b>User</b> api in our case, enter url like below.

```ruby
http://localhost:3000/users.json
http://localhost:3000/users/1.json
```

If API authenticaion is requred, e.g. <b>Photo</b> in our case, enter url like below. 

```ruby
http://localhost:3000/api/v1/photos.json?token=22XRYWnwHdMrYthba1PbtAtt
http://localhost:3000/api/v1/photos/1.json?token=22XRYWnwHdMrYthba1PbtAtt
```

<b>3. Use API client</b>


##Parse JSON API

There are 4 ways to parse a JSON API with Ruby.

* <b>net/http</b>
* <b>Httparty</b>
* <b>rest-client</b>
* <b>Faraday</b>
	

##An Example
An example of showing how to call REST_API and parse JSON data is demonstrated in the application 'rest_api_client'.


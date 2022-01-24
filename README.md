
# README

The project is still incomplete. The in-completed parts are Projects (update and delete) and Contents. 

### API Documentation
Postman collection for the API provided by this backend service can be found at
https://documenter.getpostman.com/view/16913403/UVXkma4F


### References
- [Ruby on Rails API with JWT Auth Tutorial](https://dev.to/alexmercedcoder/ruby-on-rails-api-with-jwt-auth-tutorial-go2)
- [Rails Guide](https://guides.rubyonrails.org/)

### Additional Gems used
- rspec-rails: for extending Rails' built-in testing framework to support rspec.
- bcrypt: to encrypt new user passwords and verify where passwords at login match the encrypted password in our database.
- rack-cors: to manage Cross Origin Resource Sharing (CORS) and determine which URLs are allowed to make requests to our server.
- jwt: to create and decode JWT token.

### Modifications to API Documentation or the requirements
Thumbnail in the project has been changed to string instead of a file, for simplicity.

### Steps for running the server
- Checkout the source code
- Create the required database: `bin/rails db:create && rails db:migrate`
- If required gems are not present, run: `./bin/bundle install`
- Run the server: `./bin/rails s`
- Access the api server at http://127.0.0.1:3000 via appropriate api calls.
  `




Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


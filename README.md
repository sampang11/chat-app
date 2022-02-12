# README

* Ruby: 2.6.3
* Rails: 6.0.4.4

* GEM used:
gem "bcrypt" 
gem "pry" => Debugging code
gem "devise" => user creation and authentication
gem "jwt" => Token generation for authentication
gem "kaminari" => Pagination
gem "rspec-rails" => For writing test cases
gem "factory_bot_rails" => creating record for test case
gem "faker" => Generating Fake data

* Database 
Script to run: 
rake db:create db:migrate

if you want load some users
rake db:seed


* Running Test Cases
rspec spec

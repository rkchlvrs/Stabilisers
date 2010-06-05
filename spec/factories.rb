# this will get loaded whenever RSpec runs
# by using :user we ensure that factory_girl knows to create an instance of User

Factory.define :user do |user|
  user.name                   "Rik Chilvers"
  user.email                  "rik@plus.gd"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end
Factory.define :user do |user|
  user.username               "jjones"
  user.realname               "Jay Jones"
  user.email                  "jjones@example.com"
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :bookmark do |bookmark|
  bookmark.name   "Google"
  bookmark.url    "http://www.google.com"
end

require "faker"

namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    make_users

  end

  def make_users

    realname = "Jefferson Carley"
    username = "jcarley"
    email = "jeff.carley@gmail.com"
    password = "password"

    user = User.create! :username => username,
                        :realname => realname,
                        :email    => email,
                        :password => password,
                        :password_confirmation => password

    make_bookmarks user

    15.times do |n|
      realname = Faker::Name.name
      username = Faker::Internet.user_name(realname)
      email = Faker::Internet.email(realname)
      password = "password"

      user = User.create! :username => username,
                          :realname => realname,
                          :email    => email,
                          :password => password,
                          :password_confirmation => password

      make_bookmarks user
    end

  end

  def make_bookmarks(user)
    
    name = "Google"
    url = "http://www.google.com"
    user.link_to Bookmark.new :name => name, :url => url


    3.times do |n|
      name = Faker::Internet.domain_name
      url = Faker::Internet.url

      user.link_to Bookmark.new :name => name, :url => url

    end

  end

end

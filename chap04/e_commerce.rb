require 'rubygems'
require 'mongo'

class ECommerce
  @@connection = Mongo::Client.new(['127.0.0.1:27017'], :database => 'eCommerce')
  @@db = @@connection.database

  def connection
    @@connection
  end

  def database
    @@db
  end
end

# Let everyone know about our success
puts 'Connected to MongoDB!'

require 'rubygems'
require 'mongo'

# Initialize a global reference to the mongo client on `localhost`
$client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'tutorial')
Mongo::Logger.logger.level = ::Logger::ERROR

# Similarly, initialize a global reference to the `users` collection
$users = $client[:users]

# Let everyone know about our success
puts 'Connected to MongoDB!'

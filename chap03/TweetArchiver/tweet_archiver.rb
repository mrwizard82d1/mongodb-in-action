$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'mongo'
require 'twitter'
require 'config'

class TweetArchiver
  def initialize(tag)
    connection = Mongo::Client.new("mongodb://#{DATABASE_HOST}:#{DATABASE_PORT}/#{DATABASE_NAME}")
    @tweets = connection["#{COLLECTION_NAME}"]
    @tweets.indexes.create_one({tags: 1, id: -1})
    @tag = tag
    @tweets_found = 0

    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token = TOKEN
      config.access_token_secret = TOKEN_SECRET
    end
  end

  # Public service providing feedback
  def update
    puts "Starting Twitter search for '#{@tag}'...."
    save_tweets_for(@tag)
    puts "Saved #{@tweets_found} Tweets.\n\n"
  end

  private
  def save_tweets_for(term)
    @twitter_client.search(term).each do |tweet|
      @tweets_found += 1
      tweet_doc = tweet.to_h
      tweet_doc[:tags] = term
      tweet_doc[:_id] = tweet_doc[:id]
      @tweets.insert_one(tweet_doc)
    end
  end
end
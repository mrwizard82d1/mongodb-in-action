$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'mongo'
require 'twitter'
require 'config'

class TweetArchiver
  def initialize(tag)
    client = Mongo::Client.new(["#{DATABASE_HOST}:#{DATABASE_PORT}"], :database => "#{DATABASE_NAME}")
    @tweets = client["#{COLLECTION_NAME}"]
    @tweets.indexes.drop_all
    @tweets.indexes.create_many([{key: {tags: 1}}, {key: {id: -1}}])
    @tag = tag
    @tweets_found = 0

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token = TOKEN
      config.access_token_secret = TOKEN_SECRET
    end
  end

  def save_tweets_for(term)
    @client.search(term).each do |tweet|
      @tweets_found += 1
      tweet_doc = tweet.to_h
      tweet_doc[:tags] = term
      tweet_doc[:_id] = tweet_doc[:id]
      @tweets.insert_one(tweet_doc)
    end
  end
end
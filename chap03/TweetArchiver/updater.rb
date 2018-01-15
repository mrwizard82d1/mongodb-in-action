$LOAD_PATH << File.dirname(__FILE__)

require 'config'
require 'tweet_archiver'

TAGS.each do |tag|
  archive = TweetArchiver.new(tag)
  archive.update
end
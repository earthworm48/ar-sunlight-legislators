require_relative 'db/config'
require_relative 'app/models/legislator'
require 'byebug'

require 'twitter'

class MyTwitter

  attr_reader :client

  def initialize

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "6bMMl7UDOTjvq6Vfjnyd0j1Bo"
      config.consumer_secret     = "XgUXpZvNw0fjJhiGWHGMoGIg945KrPTDyQzOUq6kcjtyGcEzll"
      config.access_token        = "612492229-kC4Q3YxNW13T9MpKM9E5P09eXvJHomEfLJ0aivM5"
      config.access_token_secret = "IZquwL9qepLAvOBwuvYPfkNyuwWrQ2yj8omfR5PluwQk4"

    end

  end

end

# get all legislator
# check if twitter_id not empty
# get top 10 tweets
# save into array of hash
byebug
leg = Legislator.all

ttt = MyTwitter.new

tweet_options = { result_type: "recent", count: 1}

leg.each do |l|

  unless l[:twitter_id] == ""
    begin
      puts "READING: #{l[:twitter_id]}"
      if ttt.client.user?("#{l[:twitter_id]}")
        ttt.client.user_timeline("#{l[:twitter_id]}", {count: 10}).each do |twt|

          attributes_hash = {}

          attributes_hash[:twit_id] = twt.id
          attributes_hash[:twit] = twt.text
          attributes_hash[:legislator_id] = l[:id]

          unless Tweet.twit_exist?(twt.id)
            Tweet.create! (attributes_hash)
            puts "------------USER EXPORT DONE #{twt.id} - #{l[:twitter_id]}------------"
          else
            puts "------------USER TWEET EXIST #{twt.id} - #{l[:twitter_id]}------------"
          end

        end
      else
        puts "++++++++++++USER DOES NOT EXIST - #{l[:twitter_id]}++++++++++++"
      end
    rescue
      puts "===============ERROR READING USER - #{l[:twitter_id]}==============="
    end

  end

end
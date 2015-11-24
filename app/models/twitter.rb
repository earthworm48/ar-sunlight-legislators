require_relative '../../db/config'

class Tweet < ActiveRecord::Base
  belongs_to :legislators

  # def initialize(twit_id, twit, legislator_id)
  #   attributes_hash = {}
  #   attributes_hash[:twit_id] = twit_id
  #   attributes_hash[:twit] = twit
  #   attributes_hash[:legislator_id] = legislator_id

  #   Tweet.create! (attributes_hash)
  # end

  def self.twit_exist?(twit_id)
    if Tweet.where(twit_id: twit_id).count > 0
      return true
    else
      return false
    end
  end

end
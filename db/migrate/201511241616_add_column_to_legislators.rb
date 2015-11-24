require_relative '../config'

# this is where you should use an ActiveRecord migration to

class AddColumnToLegislators < ActiveRecord::Migration
  def change
    add_column :legislators, :twitter_id, :string
  end
end

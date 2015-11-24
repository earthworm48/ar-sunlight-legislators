require 'csv'
require 'byebug'
require_relative '../app/models/legislator'

class SunlightLegislatorsImporter < ActiveRecord::Base
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      person = {}
      row.each do |field, value|
        # TODO: begin
        if Legislator.attribute_names.include? field
          person[field] = value
        end     
        # TODO: end
      end
      Legislator.create!(person)
      # legislator = Legislator.new()
      # if legislator.save
      #   p "success"
      # else
      #   legislator.errors #=> "can't be blank， format invalid
      # end
    end
  end
end

SunlightLegislatorsImporter.import("../db/data/legislators.csv")

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end

require_relative '../app/models/legislator'
require 'byebug'

class Query

	def twitter

	end

	def state(string)
		puts "Senators:"
		array = Legislator.where(title: "Sen", state: string)
		array.each do |x|
			puts x.firstname + " " + x.lastname + "(" + x.party +
				")"

		end
		puts "Representatives:"
		array = Legislator.where(title: "Rep", state: string)
		array.each do |x|
			puts x.firstname + " " + x.lastname + "(" + x.party +
				")"
		end
	end

	def gender(string)

		total_s = Legislator.where(title: "Sen").count
		portion_s = Legislator.where(title: "Sen", gender: string).count
		percentage_s = (portion_s.to_f / total_s.to_f) * 100

		total_r = Legislator.where(title: "Rep").count
		portion_r = Legislator.where(title: "Rep", gender: string).count
		percentage_r = (portion_r.to_f / total_r.to_f) * 100

		if string == 'M'
			puts "Male" + " Senators: " + "#{portion_s}" + " (#{percentage_s.to_i})%"
			puts "Male" + " Senators: " + "#{portion_r}" + " (#{percentage_r.to_i})%"
		else
			puts "Female" + " Representatives: " + "#{portion_s}" + " (#{percentage_s.to_i})%"
			puts "Female" + " Representatives: " + "#{portion_r}" + " (#{percentage_r.to_i})%"
		end
	end

	def total
		Legislator.where(title:"Rep").group(:title).count.each do |key,value|
			puts "Representatives: #{value}"
		end
		Legislator.where(title:"Sen").group(:title).count.each do |key,value|
			puts "Senators: #{value}"
		end
	end

	def self.active_congress_people
		all = []
		Legislator.where(in_office: "1",title:"Rep").group(:state).count.each do |x|
			all << x
		end

		Legislator.where(in_office: "1",title:"Sen").group(:state).count.each do |x|
			all << x
		end

		all.sort_by! do |x|
			x[0]
		end

		final = []
		all.each_slice(2) do |a|
			# byebug
			y = []
			a.flatten!
			y << a[0]
			y << a[3]
			y << a[1]
			final << y
		end

		final.sort_by! do |x|
			x[1] + x[2]
		end
		final.reverse.each do |x|
			puts "#{x[0]}: #{x[2]} Senators, #{x[1]} Representative(s)"
		end

	end
end




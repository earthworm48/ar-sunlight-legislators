require_relative '../app/models/legislator'
require 'byebug'

# def state(string)
# 	puts "Senators:"
# 	array = Legislator.where(title: "Sen", state: string)
# 	array.each do |x|
# 		puts x.firstname + " " + x.lastname + "(" + x.party + 
# 			")"

# 	end
# 	puts "Representatives:"
# 	array = Legislator.where(title: "Rep", state: string)
# 	array.each do |x|
# 		puts x.firstname + " " + x.lastname + "(" + x.party + 
# 			")"
# 	end
# end

# state("HI")

def gender(string)
	print string + " Senators: " 

	puts total = Legislator.where(title: "Sen").count
	puts portion = Legislator.where(title: "Sen", gender: string).count
	byebug
	puts percentage = portion / total * 100 

	print string + " Representatives: "

	puts Legislator.where(title: "Rep", gender: string).count
		# array = Legislator.where(title: "Sen", state: string)
		# array.each do |x|
		# 	puts x.firstname + " " + x.lastname + "(" + x.party + 
		# 		")"

end

gender("M")
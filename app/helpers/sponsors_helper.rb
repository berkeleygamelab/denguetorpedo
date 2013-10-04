module SponsorsHelper
	def telephone_format(number)
		if number.size == 10
			number[0..1] + ")" + number[2..5] + "." + number[6..number.size]
		elsif number.size == 11
			number[0..2] + ")" + number[3..6] + "." + number[7..number.size]
		else
			number
		end
	end
end

module SponsorsHelper
	def telephone_format(number)
		if number.size > 9
			number[0..2] + ")" + number[3..6] + "." + number[7..number.size]
		else
			number
		end
	end
end

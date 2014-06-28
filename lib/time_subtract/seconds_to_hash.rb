require 'active_support/all'

module SecondsToHash
	def time_diff_hash
		number = self.abs
		intervals = [:year, :month, :day, :hour, :minute, :second]
		date_time_hs = {}
		intervals.each do |interval|
			date_time_hs[interval] = (number / (1.send interval)).to_i
			number = number % (1.send interval)
		end
		date_time_hs
	end
end

Numeric.send :include, SecondsToHash
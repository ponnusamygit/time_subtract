require 'active_support/all'

module SecondsToHash

	DEFAULT = [:year, :month, :day, :hour, :minute, :second]

	def time_diff_hash(*intervals)
		number = self.abs

		intervals = intervals.present? ? intervals.select{ |interval| interval.in? DEFAULT } : DEFAULT

		date_time_hs = {}
		intervals.each do |interval|
			date_time_hs[interval] = (number / (1.send interval)).to_i
			number = number % (1.send interval)
		end
		date_time_hs
	end
end

Numeric.send :include, SecondsToHash
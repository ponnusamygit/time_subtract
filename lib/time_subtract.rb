require "time_subtract/version"
require "time_subtract/seconds_to_hash"
require "time_subtract/time_intervals_to_string"
require 'active_support/all'

module TimeSubtract
	def smart_subtract _time
		_seconds = self - _time 
		TimeIntervalsToString.interval_to_string _seconds.time_diff_hash
	end
end

Time.send :include, TimeSubtract

require "time_subtract/version"
require "time_subtract/seconds_to_hash"
require "time_subtract/time_intervals_to_string"
require 'active_support/all'

module TimeSubtract
	def smart_subtract(_time, is_hash={hash: false})
		_seconds = self.to_time - _time.to_time
		if is_hash[:hash]
			_seconds.time_diff_hash
		else
			TimeIntervalsToString.interval_to_string _seconds.time_diff_hash
		end
	end
end

Time.send :include, TimeSubtract
Date.send :include, TimeSubtract

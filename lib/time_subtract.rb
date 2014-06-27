require "time_subtract/version"
require "time_subtract/seconds_to_hash"
require 'active_support/all'

module TimeSubtract
	def smart_subtract time

	end
end

Time.send :include, TimeSubtract

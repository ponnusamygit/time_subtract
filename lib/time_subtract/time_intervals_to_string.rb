module TimeIntervalsToString
	def self.interval_to_string arg_hash
		# Raise Wrong Argument Type Error
		if !(arg_hash.is_a? Hash)
			raise 'WrongArgumentType'
		end

		order = [:year, :month, :day, :hour, :minute, :second]

		# Keep only selected key values
		arg_hash.keep_if{|k, v| order.include? k}

		# No Key match exception
		if arg_hash.blank?
			raise 'NoKeyMatch'
		end

		# Order the hash with our order
		ordered_hash = Hash[arg_hash.sort_by {|k, _| order.index k}]	

		out_string = [] 
		ordered_hash.each do |interval, value|
			out_string  << "#{value} #{interval.to_s.pluralize(value)}" unless value.zero?
		end
		out_string.join(' ')
	end

end
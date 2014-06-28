require 'spec_helper'

describe TimeSubtract do
  it 'Module TimeSubtract included Time' do
  	expect(Time.included_modules).to include(TimeSubtract)
  end

  describe '12/10/2001 subtract 27/06/2014' do
	it 'Have a method named smart_subtract' do
		time1 = Time.new(2001, 10, 12, 10, 12, 30)
		expect(time1.respond_to? 'smart_subtract').to eq(true)
	end

	describe 'Diffenence' do
		begin
			time1 = Time.now
		end

		it '10 seconds' do 
			time2 = time1 + 10.seconds
			expect(time1.smart_subtract time2).to eq('10 seconds')	
		end

		it '20 minutes 5 seconds' do
			time2 = time1 + 1205.seconds
			expect(time1.smart_subtract time2).to eq('20 minutes 5 seconds')	
		end

		it '2 hours 3 minutes 4 seconds' do
			time2 = time1 + 7384.seconds
			expect(time1.smart_subtract time2).to eq('2 hours 3 minutes 4 seconds')	
		end

		it '2 days 3 hours 4 minutes 5 seconds' do
			time2 = time1 + 183845.seconds
			expect(time1.smart_subtract time2).to eq('2 days 3 hours 4 minutes 5 seconds')	
		end

		it '7 month 2 days 3 hours 4 minutes 5 seconds' do
			time2 = time1 + 18327845.seconds
			expect(time1.smart_subtract time2).to eq('7 months 2 days 3 hours 4 minutes 5 seconds')	
		end

		it '3 years 2 days 3 hours 4 minutes 5 seconds' do
			time2 = time1 + 94856645.seconds
			expect(time1.smart_subtract time2).to eq('3 years 2 days 3 hours 4 minutes 5 seconds')	
		end
	end
  end
end

describe SecondsToHash do
	begin
		num = 123456
		negative_num = 0-num
		expected = {:year => 0, :month => 0, :day => 1, :hour=> 10, :minute => 17, :second => 36}
	end

	it 'Inclue SecondsToHash to Numeric class' do
		expect(Numeric.included_modules).to include(SecondsToHash)
	end

	it 'Have instance method time_diff_hash' do
		expect(num.respond_to? 'time_diff_hash').to eq(true)
	end

	describe 'should retrun' do
		it 'value as hash' do
			expect(num.time_diff_hash).to be_a(Hash)
		end

		it 'values only as fixnum' do
			date_hash = num.time_diff_hash
			date_hash.each do |interval, value|
				expect(value).to be_a Fixnum
			end
		end

		it 'values as unsigned positive number' do
			date_hash = negative_num.time_diff_hash
			date_hash.each do |interval, value|
				expect(value).to be >= 0
			end
		end

		it 'value in order [:year, :month, :day, :hour, :minute, :second]' do
			orders = {:year => 0, :month => 1, :day => 2, :hour => 3, :minute => 4, :second => 5}
			date_hash = num.time_diff_hash.to_a
			orders.each do |interval, order|
				expect(date_hash[order]).to include(interval)
			end
		end

		it 'Must be 0 year 0 month 1 day 10 hour 17 minute 36 second' do
			expect(num.time_diff_hash).to eq(expected)
		end
	end

end

describe TimeIntervalsToString do
	it 'should have method interval_to_string' do
		expect(TimeIntervalsToString.respond_to? 'interval_to_string').to eq(true)
	end

	describe 'Accept [:year, :month, :day, :hour, :minute, :second] keys' do
		begin
			intervals = {:year => 10, :month => 0, :day => 13, :hour => 3, :minute => 14, :second => 25}
			wrong_order = {:second => 25, :hour => 3, :day => 13, :month => 0, :minute => 14, :year => 10}
			with_other_key = {:other => 'key', :second => 25, :hour => 3, :day => 13, :month => 0, :minute => 14, :year => 10}
			no_key_match = {:weight => 80, :height => 166 , :age => 22}
			expected = '10 years 13 days 3 hours 14 minutes 25 seconds'
		end

		it 'And return string' do
			expect(TimeIntervalsToString.interval_to_string(intervals)).to eq(expected)
		end

		it 'should have with pluralized form' do
			expect(TimeIntervalsToString.interval_to_string(intervals)).to eq(expected)
		end

		it 'with out Zero values' do
			expect(TimeIntervalsToString.interval_to_string(intervals)).to eq(expected)
		end

		it 'Re-order the worng parameter' do
			expect(TimeIntervalsToString.interval_to_string(wrong_order)).to eq(expected)
		end

		it "Any other keys occured don't parse other keys" do
			expect(TimeIntervalsToString.interval_to_string(with_other_key)).to eq(expected)
		end

		it 'Are else raise no key is matched, expected [:year, :month, :day, :hour, :minute, :second] keys' do
			expect {TimeIntervalsToString.interval_to_string(no_key_match) }.to raise_error 'NoKeyMatch'
		end

		it "Should raise 'Argument miss match expected Hash' when differnet type argumenr" do
			expect {TimeIntervalsToString.interval_to_string 'Raise Error' }.to raise_error 'WrongArgumentType'
		end
	end
end

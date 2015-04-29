require 'spec_helper'

describe TimeSubtract do
  it 'should Module TimeSubtract included in Time' do
  	expect(Time.included_modules).to include(TimeSubtract)
  end

  it 'should Module TimeSubtract included in Date' do
		expect(Date.included_modules).to include(TimeSubtract)
  end

  describe '12/10/2001 subtract 27/06/2014' do
		it 'Have a method named smart_subtract' do
			time1 = Time.new(2001, 10, 12, 10, 12, 30)
			expect(time1.respond_to? 'smart_subtract').to eq(true)
		end

		describe 'Diffenence for Time' do
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

			it '3 years 2 days 3 hours 4 minutes 5 seconds as hash output' do
				time2 = time1 + 94856645.seconds
				expect(time1.smart_subtract(time2, hash: true)).to eq({:year=>3, :month=>0, :day=>2, :hour=>3, :minute=>4, :second=>5})
			end
		end

		describe 'Diffenence for date' do
			begin
				date = Date.today
			end

			it '2 days' do
				date2 = date + 2.days
				expect(date.smart_subtract date2).to eq('2 days')	
			end

			it '2 months 5 days' do
				date2 = date + 65.days
				expect(date.smart_subtract date2).to eq('2 months 5 days')	
			end

			it '1 year 2 months 29 days 18 hours for 365 days and .25 days' do
				date2 = date - 455.days
				expect(date.smart_subtract date2).to eq('1 year 2 months 29 days 18 hours')
			end

			it '1 year 2 months 29 days 18 hours as hash output' do
				date2 = date - 455.days
				expect(date.smart_subtract(date2, hash: true)).to eq({:year=>1, :month=>2, :day=>29, :hour=>18, :minute=>0, :second=>0})
			end
		end
  end
end

describe SecondsToHash do
	begin
		num = 123456
		num2 = 123456789
		negative_num = 0-num
		expected = {:year => 0, :month => 0, :day => 1, :hour=> 10, :minute => 17, :second => 36}
	end

	it 'Inclue SecondsToHash to Numeric class' do
		expect(Numeric.included_modules).to include(SecondsToHash)
	end

	it 'Have instance method time_diff_hash' do
		expect(num.respond_to? 'time_diff_hash').to eq(true)
	end

	describe 'Without any argument' do
		it ' should retrun value as hash' do
			expect(num.time_diff_hash).to be_a(Hash)
		end

		it ' should retrun values only as fixnum' do
			date_hash = num.time_diff_hash
			date_hash.each do |interval, value|
				expect(value).to be_a Fixnum
			end
		end

		it ' should retrun values as unsigned positive number' do
			date_hash = negative_num.time_diff_hash
			date_hash.each do |interval, value|
				expect(value).to be >= 0
			end
		end

		it 'should retrun values in order [:year, :month, :day, :hour, :minute, :second]' do
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

	describe 'With custome arguments' do
		it 'should return given argument values' do
			expect(num2.time_diff_hash(:year, :month)).to eq({:year=>3, :month=>11})
		end

		it 'should not process wrong arguments' do
			expect(num2.time_diff_hash(:year, :month, :wrong)).to eq({:year=>3, :month=>11})
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

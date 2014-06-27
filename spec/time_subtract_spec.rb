require 'spec_helper'

describe TimeSubtract do

  it 'Module TimeSubtract included Time' do
  	expect(Time.included_modules).to include(TimeSubtract)
  end

  describe '12/10/2001 subtract 27/06/2014' do
  	begin
  		dob = Time.new(2001, 10, 12, 10, 12, 30)	  		
  		now = Time.new(2014, 06, 27, 9, 18, 26)
  	end

	it 'Have a method named smart_subtract' do
		expect(dob.respond_to? 'smart_subtract').to eq(true)
	end

	describe 'should return' do
		it 'string value' do
			expect(dob.smart_subtract now).to be_a(String)
		end

		it "'25 year 10 month 11 day 14 hour 44 minute 14 second'"

		it 'with our Zero values'

	end
  end
end

describe SecondsToHash do
	begin
		num = 123456
	end

	it 'Inclue SecondsToHash to Numeric class' do
		expect(Numeric.included_modules).to include(SecondsToHash)
	end

	it 'Have instance method date_time_hash' do
		expect(num.respond_to? 'date_time_hash').to eq(true)
	end

	describe 'should retrun' do

		it 'value as hash' do
			expect(num.date_time_hash).to be_a(Hash)
		end

		it 'values only as fixnum' do
			date_hash = num.date_time_hash
			date_hash.each do |interval, value|
				expect(value).to be_a Fixnum
			end
		end

		it 'value in order [:year, :month, :day, :hour, :minute, :second]' do
			orders = {:year => 0, :month => 1, :day => 2, :hour => 3, :minute => 4, :second => 5}
			date_hash = num.date_time_hash.to_a
			orders.each do |interval, order|
				expect(date_hash[order]).to include(interval)
			end
		end
	end

end

describe TimeIntervalsToString do
	it 'Inclue TimeIntervalsToString to Hash class' do
		expect(Hash.included_modules).to include(TimeIntervalsToString)
	end
end

# TimeSubtract [![Code Climate](https://codeclimate.com/github/ponnusamygit/time_subtract.png)](https://codeclimate.com/github/ponnusamygit/time_subtract) [![Dependency Status](https://gemnasium.com/ponnusamygit/time_subtract.svg)](https://gemnasium.com/ponnusamygit/time_subtract)[![Gem Version](https://badge.fury.io/rb/time_subtract.svg)](http://badge.fury.io/rb/time_subtract)


Get the difference between two time

## Installation

Add this line to your application's Gemfile:

    gem 'time_subtract'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_subtract

## Usage

	time.smart_subtract time2

	date.smart_subtract date2

	# This will return 

		'2 years 1 month 8 days 10 hours 5 minutes 23 seconds'.

If you want result as hash 
	
	time.smart_subtract(time2, hash: true)
	
	# or

	date.smart_subtract(date2, hash: true)
	
	# or
	
	(time - time2).time_diff_hash
	
	# or
	
	seconds = 123456
	
	seconds.time_diff_hash

	# This will return

	#=> {:year => 0, :month => 0, :day => 1, :hour=> 10, :minute => 17, :second => 36}


## Contributing

1. Fork it ( https://github.com/ponnusamygit/time_subtract/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Maintainer

* [Ponnusamy](https://github.com/ponnusamygit)

## Todo

- Get format from user

## Testing

Time Subtract uses RSpec for test coverage. Inside the gem
directory, you can run the specs with:

    rpsec spec/time_subtract_spec.rb

License
----

MIT

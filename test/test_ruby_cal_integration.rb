
def test_31_month
	assert_equal(`cal 1 2013`,`ruby ruby_cal.rb 1 2013`)
end

def test_30_day_month
	assert_equal(`cal 4 2013`,`ruby ruby_cal.rb 3 2013`)
end

def test_february_leap_year
	assert_equal(`cal 2 2012`, `ruby ruby_cal.rb 2 2012`)
end

def test_february_non_leap_year
	assert_equal(`cal 2 2013`, `ruby ruby_cal.rb 2 2013`)
end

def test_400_year_leap_year
	assert_equal(`cal 2 2000`,`ruby ruby_cal.rb 2 2000`)
end

def test_common_year_exceptions
	assert_equal(`cal 2 2100`,`ruby ruby_cal.rb 2 2100`)
end

def test_date_in_past
	assert_equal(`cal 7 1856`,`ruby ruby_cal.rb 7 1856`)
end

def test_date_in_future
	assert_equal(`cal 10 2970`,`ruby ruby_cal.rb 3 2970`)
end


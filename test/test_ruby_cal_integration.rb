require 'test/unit'

class RubyCalIntegrationTests < Test::Unit::TestCase

  def test_6_week_month
    assert_equal(`cal 6 2013`,`ruby cal.rb 6 2013`)
  end

  def test_4_week_month
    assert_equal(`cal 2 2009`,`ruby cal.rb 2 2009`)
  end

  def test_month_entered_as_string
    assert_equal(`cal February 2009`,`ruby cal.rb February 2009`)
  end

  def test_month_as_uncapitalized_string
    assert_equal(`cal march 1952`,`ruby cal.rb march 1952`)
  end

  def test_february_leap_year
    assert_equal(`cal 2 2012`, `ruby cal.rb 2 2012`)
  end

  def test_february_non_leap_year
    assert_equal(`cal 2 2013`, `ruby cal.rb 2 2013`)
  end

  def test_february_400_year_leap_year
    assert_equal(`cal 2 2000`,`ruby cal.rb 2 2000`)
  end

  def test_february_common_year_exceptions
    assert_equal(`cal 2 2100`,`ruby cal.rb 2 2100`)
  end

  def test_date_in_past
    assert_equal(`cal 7 1856`,`ruby cal.rb 7 1856`)
  end

  def test_date_in_future
    assert_equal(`cal 10 2970`,`ruby cal.rb 10 2970`)
  end

  def test_year
    assert_equal(`cal 1952`,`ruby cal.rb 1952`)
  end

  def test_leap_year
    assert_equal(`cal 1908`,`ruby cal.rb 1908`)
  end

  def test_400_year_leap_year
    assert_equal(`cal 2000`,`ruby cal.rb 2000`)
  end

  def test_common_century_exception
    assert_equal(`cal 2600`,`ruby cal.rb 2600`)
  end

end

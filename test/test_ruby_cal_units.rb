require 'test/unit'
require './ruby_cal'
require './cal_month'
require './cal_year'

class RubyCalUnitTests < Test::Unit::TestCase

  def test_01_returns_error_if_negative_month
    assert_raise ArgumentError do
      calendar = Cal.new(-4, 2013)
    end
  end

  def test_01a_returns_error_if_negative_month_str
    assert_raise ArgumentError do
      calendar = Cal.new "-4", 2013
    end
  end

  def test_01b_returns_error_if_negative_year
    assert_raise ArgumentError do
      calendar = Cal.new 4, -2013
    end
  end

  def test_01c_returns_error_if_negative_year_str
    assert_raise ArgumentError do
      calendar = Cal.new 4, "-2013"
    end
  end

  def test_02_returns_error_if_year_missing
    assert_raise ArgumentError do
      calendar = Cal.new 12
    end
  end

  def test_03_returns_error_if_invalid_year
    assert_raise ArgumentError do
      calendar = Cal.new 12, 19065
    end
  end

  def test_04_returns_error_if_year_too_late
    assert_raise ArgumentError do
      calendar = Cal.new 12, 3078
    end
  end

  def test_05_returns_error_if_year_too_early
    assert_raise ArgumentError do
      calendar = Cal.new 12, 1640
    end
  end

  def test_06_returns_error_if_invalid_month
    assert_raise ArgumentError do
      calendar = Cal.new 230, 2013
    end
  end

  def test_07_returns_error_if_invalid_month
    assert_raise NameError do
      calendar = Cal.new Arpil, 2013
    end
  end

  def test_08_return_error_if_invalid_partial_month
    assert_raise NameError do
      calendar = Cal.new Jug, 2013
    end
  end

  def test_09_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      calendar = Cal.new 13, 2013
    end
  end

  def test_10_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      calendar = Cal.new 0, 2013
    end
  end

  def test_10a_returns_error_if_5_digit_year
    assert_raise ArgumentError do
      calendar = Cal.new 20130
    end
  end

  def test_10b_returns_error_if_3_digit_year
    assert_raise ArgumentError do
      calendar = Cal.new 201
    end
  end

  def test_11_correctly_prints_month_header
    calendar = Month.new 2, 2015
    month_and_year = "   February 2015\n"
    assert_equal month_and_year, calendar.add_month_header
  end

  def test_12_correctly_prints_days_header
    calendar = Month.new 9, 2007
    days = "Su Mo Tu We Th Fr Sa\n"
    assert_equal days, calendar.add_week_header
  end

  def test_13_add_calendar_returns_combined_headers
    calendar = Month.new 11, 1962
    month_and_year = "   November 1962\n"
    days = "Su Mo Tu We Th Fr Sa\n"
    headers = month_and_year + days

    assert_equal headers, calendar.add_month_header + calendar.add_week_header
  end

  def test_14_returns_correct_first_day_of_month
    calendar = Month.new 4, 2013
    assert_equal 2, calendar.get_first_of_month
  end

  def test_15_returns_correct_first_day_february
    calendar = Month.new 2, 2013
    assert_equal 6, calendar.get_first_of_month
  end

  def test_16_returns_correct_first_day_leap_year
    calendar = Month.new 3, 2012
    assert_equal 5, calendar.get_first_of_month
  end

  def test_17_returns_correct_first_day_common_century
    calendar = Month.new 3, 2100
    assert_equal 2, calendar.get_first_of_month
  end

  def test_18_returns_correct_first_day_400_years
    calendar = Month.new 7, 2000
    assert_equal 0, calendar.get_first_of_month
  end

  def test_19_day_count_feb_leap_year
    calendar = Month.new 2, 1992
    assert_equal 29, calendar.get_month_length
  end

  def test_20_daycount_feb_non_leap_year
    calendar = Month.new 2, 1993
    assert_equal 28, calendar.get_month_length
  end

  def test_21_daycount_30_day_month
    calendar = Month.new 4, 1979
    assert_equal 30, calendar.get_month_length
  end

  def test_22_daycount_31_day_month
    calendar = Month.new 10, 1859
    assert_equal 31, calendar.get_month_length
  end

  def test_23_prints_calendar_feb_non_leap_year
    calendar = Month.new 2, 2013
    assert_equal `cal 2 2013`, calendar.render_month
  end

  def test_24_prints_calendar_feb_leap_year
    calendar = Month.new 2, 2012
    assert_equal `cal 2 2012`, calendar.render_month
  end

  def test_25_prints_calendar_other_months
    calendar = Month.new 5, 1901
    assert_equal `cal 5 1901`, calendar.render_month
  end

  def test_26_prints_calendar_octal_month
    calendar = Month.new 06, 1937
    assert_equal `cal 6 1937`, calendar.render_month
  end

  def test_27_prints_year_header_num_args_for_year
    calendar = Year.new 2015
    year_header = "                             2015\n\n"
    assert_equal year_header, calendar.add_year_header
  end

  def test_28_prints_year_header_str_args_for_year
    calendar = Year.new "2015"
    year_header = "                             2015\n\n"
    assert_equal year_header, calendar.add_year_header
  end

  def test_29_prints_month_header_num_args_for_year
    calendar = Year.new 2015
    months_header = "       April                  May                   June\n"
    assert_equal months_header, calendar.add_month_header(3)
  end

  def test_30_prints_month_header_str_args_for_year
    calendar = Year.new "2015"
    months_header = "      January               February               March\n"
    assert_equal months_header, calendar.add_month_header(0)
  end

  def test_31_prints_days_header_for_year
    calendar = Year.new 2007
    days = "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n"
    assert_equal days, calendar.add_week_header
  end

  def test_32_prints_year
    calendar = Cal.new 1969
    assert_equal `cal 1969`, calendar.print_calendar
  end

  def test_33_prints_leap_year
    calendar = Cal.new 1896
    assert_equal `cal 1896`, calendar.print_calendar
  end

  def test_34_prints_year_with_string_year
    calendar = Cal.new "1809"
    assert_equal `cal 1809`, calendar.print_calendar
  end

end

class RubyCalIntegrationTests < Test::Unit::TestCase

  def test_35_6_week_month
    assert_equal(`cal 6 2013`,`ruby cal.rb 6 2013`)
  end

  def test_36_4_week_month
    assert_equal(`cal 2 2009`,`ruby cal.rb 2 2009`)
  end

  def test_37_month_entered_as_string
    assert_equal(`cal February 2009`,`ruby cal.rb February 2009`)
  end

  def test_38_month_as_uncapitalized_string
    assert_equal(`cal march 1952`,`ruby cal.rb march 1952`)
  end

  def test_39_month_as_partial_string
    assert_equal(`cal nov 2376`,`ruby cal.rb nov 2376`)
  end

  def test_40_february_leap_year
    assert_equal(`cal 2 2012`, `ruby cal.rb 2 2012`)
  end

  def test_41_february_non_leap_year
    assert_equal(`cal 2 2013`, `ruby cal.rb 2 2013`)
  end

  def test_42_february_400_year_leap_year
    assert_equal(`cal 2 2000`,`ruby cal.rb 2 2000`)
  end

  def test_43_february_common_year_exceptions
    assert_equal(`cal 2 2100`,`ruby cal.rb 2 2100`)
  end

  def test_44_date_in_past
    assert_equal(`cal 7 1856`,`ruby cal.rb 7 1856`)
  end

  def test_45_date_in_future
    assert_equal(`cal 10 2970`,`ruby cal.rb 10 2970`)
  end

  def test_46_year
    assert_equal(`cal 1952`,`ruby cal.rb 1952`)
  end

  def test_47_leap_year
    assert_equal(`cal 1908`,`ruby cal.rb 1908`)
  end

  def test_48_400_year_leap_year
    assert_equal(`cal 2000`,`ruby cal.rb 2000`)
  end

  def test_49_common_century_exception
    assert_equal(`cal 2600`,`ruby cal.rb 2600`)
  end

end

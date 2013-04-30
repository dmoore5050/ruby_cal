require 'test/unit'
require './ruby_cal'

class RubyCalUnitTests < Test::Unit::TestCase

  def test_01_returns_error_if_negative_month
    assert_raise ArgumentError do
      calendar = Cal.new -4, 2013
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

  def test_06a_returns_error_if_invalid_month
    assert_raise NameError do
      calendar = Cal.new Arpil, 2013
    end
  end

  def test_07_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      calendar = Cal.new 13, 2013
    end
  end

  def test_08_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      calendar = Cal.new 0, 2013
    end
  end

  def test_09_correctly_prints_month_header_num_args
    calendar = Cal.new 2, 2015
    month_and_year = "   February 2015\n"
    assert_equal month_and_year, calendar.print_month_header
  end

  def test_09a_correctly_prints_month_header_name_arg
    calendar = Cal.new "February", 2015
    month_and_year = "   February 2015\n"
    assert_equal month_and_year, calendar.print_month_header
  end

  def test_09b_correctly_prints_month_header_str_args
    calendar = Cal.new "2", "2015"
    month_and_year = "   February 2015\n"
    assert_equal month_and_year, calendar.print_month_header
  end

  def test_09c_correctly_prints_month_header_partial_str
    calendar = Cal.new "oct", "2015"
    month_and_year = "    October 2015\n"
    assert_equal month_and_year, calendar.print_month_header
  end

  def test_09d_correctly_prints_month_header_octal
    calendar = Cal.new "09", 2015
    month_and_year = "   September 2015\n"
    assert_equal month_and_year, calendar.print_month_header
  end

  def test_10_correctly_prints_days_header
    calendar = Cal.new 9, 2007
    days = "Su Mo Tu We Th Fr Sa\n"
    assert_equal days, calendar.print_days_header
  end

  def test_11_print_calendar_returns_combined_headers
    calendar = Cal.new 11, 1962
    month_and_year = "   November 1962\n"
    days = "Su Mo Tu We Th Fr Sa\n"
    headers = month_and_year + days

    assert_equal headers, calendar.print_month_header + calendar.print_days_header
  end

  def test_12_returns_correct_first_day_of_month
    calendar = Cal.new 4, 2013
    assert_equal 2, calendar.get_first_of_month
  end

  def test_13_returns_correct_first_day_february
    calendar = Cal.new 2, 2013
    assert_equal 6, calendar.get_first_of_month
  end

  def test_14_returns_correct_first_day_leap_year
    calendar = Cal.new 3, 2012
    assert_equal 5, calendar.get_first_of_month
  end

  def test_15_returns_correct_first_day_common_century
    calendar = Cal.new 3, 2100
    assert_equal 2, calendar.get_first_of_month
  end

  def test_16_returns_correct_first_day_400_years
    calendar = Cal.new 7, 2000
    assert_equal 0, calendar.get_first_of_month
  end

  def test_17_spaces_count_correct_sat
    calendar = Cal.new 7, 2000
    assert_equal 6, calendar.get_blank_units( 0 )
  end

  def test_18_spaces_count_correct_rest
    calendar = Cal.new 3, 2012
    assert_equal 4, calendar.get_blank_units( 5 )
  end

  def test_19_day_count_feb_leap_year
    calendar = Cal.new 2, 1992
    assert_equal 29, calendar.get_days_in_month
  end

  def test_20_daycount_feb_non_leap_year
    calendar = Cal.new 2, 1993
    assert_equal 28, calendar.get_days_in_month
  end

  def test_21_daycount_30_day_month
    calendar = Cal.new 4, 1979
    assert_equal 30, calendar.get_days_in_month
  end

  def test_22_daycount_31_day_month
    calendar = Cal.new 10, 1859
    assert_equal 31, calendar.get_days_in_month
  end

  def test_23_prints_calendar_feb_non_leap_year
    calendar = Cal.new 2, 2013
    assert_equal `cal 2 2013`, calendar.print_calendar
  end

  def test_24_prints_calendar_feb_leap_year
    calendar = Cal.new 2, 2012
    assert_equal `cal 2 2012`, calendar.print_calendar
  end

  def test_25_prints_calendar_other_months
    calendar = Cal.new 5, 1901
    assert_equal `cal 5 1901`, calendar.print_calendar
  end

  def test_26_prints_calendar_octal_month
    calendar = Cal.new 06, 1937
    assert_equal `cal 6 1937`, calendar.print_calendar
  end

  def test_27_prints_calendar_string_args
    calendar = Cal.new "2", "2690"
    assert_equal `cal 2 2690`, calendar.print_calendar
  end

  def test_28_prints_calendar_partial_month_string
    calendar = Cal.new "octob", "2700"
    assert_equal `cal 10 2700`, calendar.print_calendar
  end

  def test_29_prints_calendar_string_args
    calendar = Cal.new "January", "1820"
    assert_equal `cal 1 1820`, calendar.print_calendar
  end

  def test_30_prints_year_header_num_args_for_year
    calendar = Cal.new 2015
    year_header = "                             2015\n\n"
    assert_equal year_header, calendar.print_year_header
  end

  def test_31_prints_year_header_str_args_for_year
    calendar = Cal.new "2015"
    year_header = "                             2015\n\n"
    assert_equal year_header, calendar.print_year_header
  end

  def test_32_prints_month_header_num_args_for_year
    calendar = Cal.new 2015
    months_header = "       April                  May                   June\n"
    assert_equal months_header, calendar.print_month_header(3)
  end

  def test_33_prints_month_header_str_args_for_year
    calendar = Cal.new "2015"
    months_header = "      January               February               March\n"
    assert_equal months_header, calendar.print_month_header(0)
  end

  def test_34_prints_days_header_for_year
    calendar = Cal.new 2007
    days = "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n"
    assert_equal days, calendar.print_days_header
  end

  def test_35_prints_year
    calendar = Cal.new 1969
    assert_equal `cal 1969`, calendar.print_calendar
  end

  def test_36_prints_leap_year
    calendar = Cal.new 1896
    assert_equal `cal 1896`, calendar.print_calendar
  end

  def test_37_prints_year_with_string_year
    calendar = Cal.new "1809"
    assert_equal `cal 1809`, calendar.print_calendar
  end

end

# Encoding: UTF-8

require 'test/unit'
require './ruby_cal'
require './cal_month'
require './cal_year'

class RubyCalUnitTests < Test::Unit::TestCase

  def test_01_returns_error_if_negative_month
    assert_raise ArgumentError do
      Cal.new(-4, 2013)
    end
  end

  def test_02_returns_error_if_negative_month_str
    assert_raise ArgumentError do
      Cal.new '-4', 2013
    end
  end

  def test_03_returns_error_if_negative_year
    assert_raise ArgumentError do
      Cal.new 4, -2013
    end
  end

  def test_04_returns_error_if_negative_year_str
    assert_raise ArgumentError do
      Cal.new 4, '-2013'
    end
  end

  def test_05_returns_error_if_invalid_year
    assert_raise ArgumentError do
      Cal.new 7, 19065
    end
  end

  def test_06_returns_error_if_year_too_late
    assert_raise ArgumentError do
      Cal.new 11, 10075
    end
  end

  def test_07_returns_error_if_invalid_month
    assert_raise ArgumentError do
      Cal.new 230, 2013
    end
  end

  def test_08_returns_error_if_invalid_month
    assert_raise NameError do
      Cal.new Arpil, 2013
    end
  end

  def test_09_return_error_if_invalid_partial_month
    assert_raise NameError do
      Cal.new Jug, 2013
    end
  end

  def test_10_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      Cal.new 13, 2013
    end
  end

  def test_11_returns_error_if_nonexistent_month
    assert_raise ArgumentError do
      Cal.new 0, 2013
    end
  end

  def test_12_returns_error_if_5_digit_year
    assert_raise ArgumentError do
      Cal.new 20130
    end
  end

  def test_13_correctly_prints_month_header
    calendar = Month.new 2, 2015
    expected = "   February 2015\n"
    assert_equal expected, calendar.add_month_head
  end

  def test_14_correctly_prints_days_header
    calendar = Month.new 9, 2007
    expected = "Su Mo Tu We Th Fr Sa\n"
    assert_equal expected, calendar.add_week_head
  end

  def test_15_add_calendar_returns_combined_headers
    calendar = Month.new 11, 1962
    month_and_year = "   November 1962\n"
    days = "Su Mo Tu We Th Fr Sa\n"
    expected = month_and_year + days

    assert_equal expected, calendar.add_month_head + calendar.add_week_head
  end

  def test_16_returns_correct_first_day_of_month
    calendar = Month.new 4, 2013
    assert_equal 2, calendar.get_first_of_month
  end

  def test_17_returns_correct_first_day_february
    calendar = Month.new 2, 2013
    assert_equal 6, calendar.get_first_of_month
  end

  def test_18_returns_correct_first_day_leap_year
    calendar = Month.new 3, 2012
    assert_equal 5, calendar.get_first_of_month
  end

  def test_19_returns_correct_first_day_common_century
    calendar = Month.new 3, 2100
    assert_equal 2, calendar.get_first_of_month
  end

  def test_20_returns_correct_first_day_400_years
    calendar = Month.new 7, 2000
    assert_equal 0, calendar.get_first_of_month
  end

  def test_21_day_count_feb_leap_year
    calendar = Month.new 2, 1992
    assert_equal 29, calendar.get_month_length
  end

  def test_22_daycount_feb_non_leap_year
    calendar = Month.new 2, 1993
    assert_equal 28, calendar.get_month_length
  end

  def test_23_daycount_30_day_month
    calendar = Month.new 4, 1979
    assert_equal 30, calendar.get_month_length
  end

  def test_24_daycount_31_day_month
    calendar = Month.new 10, 1859
    assert_equal 31, calendar.get_month_length
  end

  def test_25_prints_calendar_feb_non_leap_year
    calendar = Month.new 2, 2013
    assert_equal `cal 2 2013`, calendar.render_month
  end

  def test_26_prints_calendar_feb_leap_year
    calendar = Month.new 2, 2012
    assert_equal `cal 2 2012`, calendar.render_month
  end

  def test_27_prints_calendar_other_months
    calendar = Month.new 5, 1901
    assert_equal `cal 5 1901`, calendar.render_month
  end

  def test_28_prints_calendar_octal_month
    calendar = Month.new 06, 1937
    assert_equal `cal 6 1937`, calendar.render_month
  end

  def test_29_prints_year
    calendar = Cal.new 1969
    assert_equal `cal 1969`, calendar.print_calendar
  end

  def test_30_prints_leap_year
    calendar = Cal.new 1896
    assert_equal `cal 1896`, calendar.print_calendar
  end

  def test_31_prints_year_with_string_year
    calendar = Cal.new '1809'
    assert_equal `cal 1809`, calendar.print_calendar
  end

end

class RubyCalIntegrationTests < Test::Unit::TestCase

  def test_32_6_week_month
    assert_equal(`cal 6 2013`, `ruby cal.rb 6 2013`)
  end

  def test_33_4_week_month
    assert_equal(`cal 2 2009`, `ruby cal.rb 2 2009`)
  end

  def test_34_month_entered_as_string
    assert_equal(`cal February 2009`, `ruby cal.rb February 2009`)
  end

  def test_35_month_as_uncapitalized_string
    assert_equal(`cal march 1952`, `ruby cal.rb march 1952`)
  end

  def test_36_month_as_partial_string
    assert_equal(`cal nov 2376`, `ruby cal.rb nov 2376`)
  end

  def test_37_february_leap_year
    assert_equal(`cal 2 2012`, `ruby cal.rb 2 2012`)
  end

  def test_38_february_non_leap_year
    assert_equal(`cal 2 2013`, `ruby cal.rb 2 2013`)
  end

  def test_39_february_400_year_leap_year
    assert_equal(`cal 2 2000`, `ruby cal.rb 2 2000`)
  end

  def test_40_february_common_century_exceptions
    assert_equal(`cal 2 2100`, `ruby cal.rb 2 2100`)
  end

  def test_41_date_in_past
    assert_equal(`cal 7 1856`, `ruby cal.rb 7 1856`)
  end

  def test_42_date_in_future
    assert_equal(`cal 10 2970`, `ruby cal.rb 10 2970`)
  end

  def test_43_year
    assert_equal(`cal 1952`, `ruby cal.rb 1952`)
  end

  def test_44_leap_year
    assert_equal(`cal 1908`, `ruby cal.rb 1908`)
  end

  def test_45_400_year_leap_year
    assert_equal(`cal 2000`, `ruby cal.rb 2000`)
  end

  def test_46_common_century_exception
    assert_equal(`cal 2600`, `ruby cal.rb 2600`)
  end

  def test_47_year_far_future
    assert_equal(`cal 9999`, `ruby cal.rb 9999`)
  end

  def test_48_leap_year_far_future
    assert_equal(`cal 9904`, `ruby cal.rb 9904`)
  end

  def test_49_400_year_leap_year_far_future
    assert_equal(`cal 9600`, `ruby cal.rb 9600`)
  end

  def test_50_common_century_exception_far_future
    assert_equal(`cal 9900`, `ruby cal.rb 9900`)
  end

  def test_51_single_digit_year_julian
    assert_equal(`cal 1`, `ruby cal.rb 1`)
  end

  def test_52_0_preceding_year_julian
    assert_equal(`cal 01`, `ruby cal.rb 01`)
  end

  def test_53_0s_preceding_year_julian
    assert_equal(`cal 001`, `ruby cal.rb 001`)
  end

  def test_54_0s_preceding_year_julian
    assert_equal(`cal 0001`, `ruby cal.rb 0001`)
  end

  def test_55_two_digit_year_julian
    assert_equal(`cal 10`, `ruby cal.rb 10`)
  end

  def test_56_three_digit_year_julian
    assert_equal(`cal 100`, `ruby cal.rb 100`)
  end

  def test_57_1752
    assert_equal(`cal 1752`, `ruby cal.rb 1752`)
  end

  def test_58_september_1752
    assert_equal(`cal 9 1752`, `ruby cal.rb 9 1752`)
  end

  def test_59_february_leap_year_julian
    assert_equal(`cal 2 8`, `ruby cal.rb 2 8`)
  end

  def test_60_february_non_leap_year_julian
    assert_equal(`cal 2 9`, `ruby cal.rb 2 9`)
  end

  def test_61_last_julian_month
    assert_equal(`cal 8 1752`, `ruby cal.rb 8 1752`)
  end

  def test_62_first_gregorian_month
    assert_equal(`cal 10 1752`, `ruby cal.rb 10 1752`)
  end

end


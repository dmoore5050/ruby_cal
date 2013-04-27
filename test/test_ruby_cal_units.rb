require 'test/unit'
require './ruby_cal'

class RubyCalIntegrationTests < Test::Unit::TestCase

  def test_01_returns_error_if_month_missing
    assert_raise ArgumentError do
      calendar = Cal.new 2013
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

  def test_09_correctly_prints_month_header
    calendar = Cal.new 2, 2015
    month_and_year = "February 2015\n"
    assert_equal month_and_year.center(20), calendar.print_month_header
  end

  def test_10_correctly_prints_days_header
    calendar = Cal.new 9, 2007
    days = "Su Mo Tu We Th Fr Sa\n"
    assert_equal days, calendar.print_days_header
  end

  def test_11_print_calendar_returns_combined_headers
    calendar = Cal.new 11, 1962
    month_and_year = "November 1962\n"
    days = "Su Mo Tu We Th Fr Sa\n"
    headers = month_and_year.center(20) + days

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
    assert_equal 6, calendar.count_initial_spaces(0)
  end

  def test_18_spaces_count_correct_other
    calendar = Cal.new 3, 2012
    assert_equal 4, calendar.count_initial_spaces(5)
  end

end












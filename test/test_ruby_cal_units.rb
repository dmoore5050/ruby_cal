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

  def test_03_returns_error_if_wrong_year_format
    calendar = Cal.new 12, 19065
    assert_raise ArgumentError do
      calendar.print_calendar
    end
  end

  def test_04_returns_error_if_year_too_late
    calendar = Cal.new 12, 3078
    assert_raise ArgumentError do
      calendar.print_calendar
    end
  end

  def test_05_returns_error_if_year_too_early
    calendar = Cal.new 12, 1640
    assert_raise ArgumentError do
      calendar.print_calendar
    end
  end

  def test_06_returns_error_if_wrong_month_format
    calendar = Cal.new 230, 2013
    assert_raise ArgumentError do
      calendar.print_calendar
    end
  end

  def test_07_returns_error_if_nonexistent_month
    calendar = Cal.new 13, 2013
    assert_raise ArgumentError do
      calendar.print_calendar
    end
  end

  def test_08_returns_error_if_nonexistent_month
    calendar = Cal.new 0, 2013
    assert_raise ArgumentError do
      calendar.print_calendar
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
    assert_equal headers, calendar.print_calendar
  end

end
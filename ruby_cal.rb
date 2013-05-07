# Encoding: UTF-8

require_relative 'cal_month'
require_relative 'cal_year'

class Cal
  attr_reader :month, :year

  MONTH_ERROR = 'Valid months are 1..12, January..December, jan..dec'
  YEAR_ERROR = 'Valid years are 1800..3000'

  MONTHS = %w(
    January
    February
    March
    April
    May
    June
    July
    August
    September
    October
    November
    December
  )

  def initialize(month_arg, year_arg = nil)
    year_arg, month_arg = month_arg, nil if year_arg.nil?

    month_arg = month_arg.to_i if month_arg =~ /^[0-9]([0-9]*)?$/

    case month_arg
    when String
      raise ArgumentError, MONTH_ERROR if month_arg.size < 3
      raise_string_match_error month_arg
      find_matching_month month_arg
    when Numeric
      raise ArgumentError, MONTH_ERROR unless (1..12).include? month_arg
      @month = month_arg
    when NilClass
      @month = nil
    end

    raise ArgumentError, YEAR_ERROR unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i

  end

  def raise_string_match_error(month_arg)
    unless MONTHS.find { | month | match_case? month_arg, month }
      raise NameError, MONTH_ERROR
    end
  end

  def find_matching_month(month_arg)
    MONTHS.each_with_index do | month, month_position |
      @month = (month_position + 1) if match_case? month_arg, month
    end
  end

  def match_case?(month_arg, month)
    /^#{ month_arg.downcase }/ =~ month.downcase
  end

  def print_calendar
    month.nil? ? build_year : build_month
  end

  def build_year
    new_year = Year.new @month, @year
    new_year.render_year
  end

  def build_month
    new_month = Month.new @month, @year
    new_month.render_month
  end

end

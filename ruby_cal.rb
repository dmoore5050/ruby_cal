# Encoding: UTF-8

require_relative 'cal_month'
require_relative 'cal_year'

class Cal

  MONTH_ERROR = 'Valid months are 1..12, January..December, Jan..Dec'
  YEAR_ERROR = 'Valid years are 1800..3000'

  def initialize(month_arg, year_arg = nil)
    year_arg, month_arg = month_arg, nil if year_arg.nil?

    month_arg = month_arg.to_i if month_arg =~ /^[0-9]([0-9]*)?$/

    case month_arg
    when String
      raise ArgumentError, MONTH_ERROR if month_arg.size < 3
      check_match_error month_arg
      find_matching_month month_arg
    when Numeric
      raise ArgumentError, MONTH_ERROR unless (1..12).include? month_arg
      @month = month_arg
    when NilClass then @month = nil
    end

    raise ArgumentError, YEAR_ERROR unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i

  end

  def check_match_error(month_arg)
    unless MONTHS.find { | the_month | months_match? month_arg, the_month }
      raise NameError, MONTH_ERROR
    end
  end

  def find_matching_month(month_arg)
    MONTHS.each_with_index do | the_month, month_position |
      @month = (month_position + 1) if months_match? month_arg, the_month
    end
  end

  def months_match?(month_arg, the_month)
    /^#{ month_arg.downcase }/ =~ the_month.downcase
  end

  def print_calendar
    @month.nil? ? build_year : build_month
  end

  def build_year
    new_year = Year.new @year
    new_year.render_year
  end

  def build_month
    new_month = Month.new @month, @year
    new_month.render_month
  end

end

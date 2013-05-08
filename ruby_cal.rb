# Encoding: UTF-8

require_relative 'cal_month'
require_relative 'cal_year'

class Cal

  MONTH_ERROR = 'Valid months are 1..12, January..December, Jan..Dec'
  YEAR_ERROR = 'Valid years are 1753..9999'

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

    raise ArgumentError, YEAR_ERROR unless (1..9999).include? year_arg.to_i
    @year = year_arg.to_i

    get_calendar_type

  end

  def get_calendar_type
    if @year < 1752
      @calendar_type = 'Julian'
    elsif @year > 1753
      @calendar_type = 'Gregorian'
    elsif @year === 1752
      unless @month.nil?
        if @month < 9
          @calendar_type = 'Julian'
        elsif @month > 9
          @calendar_type = 'Gregorian'
        end
      end
    end
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
    new_year = Year.new @year, @calendar_type
    new_year.render_year
  end

  def build_month
    new_month = Month.new @month, @year, @calendar_type
    new_month.render_month
  end

end

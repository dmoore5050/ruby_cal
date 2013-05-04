require_relative "cal_year"
require_relative "cal_month"

class Cal
  attr_reader :month, :year

  MONTH_ERROR = "Valid months are 1..12, January..December"
  YEAR_ERROR = "Valid years are 1800..3000"

  MONTHS = %w( January February March April May June July August September October November December )

  def initialize month_arg, year_arg = nil
    year_arg, month_arg = month_arg, nil if year_arg.nil?

    @month = month_arg
    month_arg = month_arg.to_i if month_arg =~ /^[0-9]([0-9]*)?$/

    if month_arg.class == String && month_arg.size >= 3
      unless MONTHS.find { |month| /^#{month_arg.downcase}/ =~ month.downcase }
        raise NameError, MONTH_ERROR
      end
      find_matching_month month_arg
    elsif month_arg.class == Fixnum
      raise ArgumentError, MONTH_ERROR unless (1..12).include? month_arg
      @month = month_arg
    elsif month_arg.nil?
      @month = nil
    else
      raise ArgumentError, MONTH_ERROR
    end

    raise ArgumentError, YEAR_ERROR unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i

  end

  def find_matching_month month_arg
    MONTHS.each_with_index do | the_month, month_position |
      @month = (month_position + 1) if /^#{month_arg.downcase}/ =~ the_month.downcase
    end
  end

  def print_calendar # Cal
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

# require "ruby_cal"
class Month
  attr_reader :week, :month, :year, :calendar #:day, ,

  MONTHS = %w( January February March April May June July August September October November December )

  def initialize month_arg, year_arg
    @calendar = ""
    @year = year_arg
    @month = month_arg
  end

  def render_month
    calendar << add_month_header << add_week_header << add_weeks
  end

  def add_month_header
    this_month = MONTHS[month - 1]
    "#{ this_month } #{ year }".center(20).rstrip + "\n"
  end

  def add_week_header
    "Su Mo Tu We Th Fr Sa\n"
  end

  def add_weeks
    weeks = ""
    calendar_unit = 1
      month_length = get_month_length
      @day = 1
      6.times do
        @week = ""
        7.times do
          add_day calendar_unit
          format_day calendar_unit, month_length
          calendar_unit += 1
        end
        weeks << week
      end
    weeks
  end

  def add_day calendar_unit
    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_month_length
    if calendar_unit <= blank_units
      week << "   "
    elsif @day <= month_length
      (1..9).include?(@day) ? week << " #{ @day } " : week << "#{ @day } "
      @day += 1
    end
  end

  def format_day calendar_unit, month_length
    @week = week.rstrip + "\n" if calendar_unit % 7 === 0
  end

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = month_values[month - 1]
    adjusted_year = (3..12).include?(month) ? year : year - 1
    (1 + ((adjusted_month * 26) / 10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year / 100)) + (adjusted_year / 400)) % 7
  end

  def get_blank_units first_day
    first_day == 0 ? 6 : first_day - 1
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]
    if months_with_31_days.include? month
      31
    elsif months_with_30_days.include? month
      30
    else
      (year % 4 != 0 or year % 100 === 0 && year % 400 != 0) ? 28 : 29
    end
  end

end

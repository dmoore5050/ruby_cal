# -*- encoding : utf-8 -*-

class Month
  attr_reader :week, :month, :year, :calendar

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

  def initialize(month_arg, year_arg)
    @calendar, @month, @year = '', month_arg, year_arg
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
    weeks, calendar_unit, @date = '', 1, 1

    6.times do
      @week = ''
      7.times do
        add_day calendar_unit
        @week = week.rstrip + "\n" if calendar_unit % 7 === 0
        calendar_unit += 1
      end
      weeks << week
    end

    weeks
  end

  def add_day(calendar_unit)
    first_day = get_first_of_month
    blank_units = first_day == 0 ? 6 : first_day - 1
    month_length = get_month_length

    if calendar_unit <= blank_units
      week << '   '
    elsif @date <= month_length
      (1..9).include?(@date) ? week << " #{ @date } " : week << "#{ @date } "
      @date += 1
    end
  end

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    m = month_values[month - 1]
    y = (3..12).include?(month) ? year : year - 1

    (1 + ((m * 26) / 10) + y + (y / 4) + (6 * (y / 100)) + (y / 400)) % 7
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]

    if months_with_31_days.include? month
      31
    elsif months_with_30_days.include? month
      30
    else
      year % 4 != 0 || year % 100 === 0 && year % 400 != 0 ? 28 : 29
    end
  end

end

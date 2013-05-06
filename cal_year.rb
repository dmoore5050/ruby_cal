# -*- encoding : utf-8 -*-

class Year
  attr_reader :week, :month, :year, :calendar, :month_counter

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
    @calendar, @month_counter, @month, @year = '', 1, month_arg, year_arg
  end

  def render_year
    calendar << add_year_header
    start_month = 0
    4.times do
      calendar << add_month_header(start_month) << add_week_header << add_weeks
      start_month += 3
    end

    calendar
  end

  def add_year_header
    year.to_s.center(62).rstrip + "\n\n"
  end

  def add_month_header(start_month)
    month_header = ''

    3.times do | month_increment |
      this_month = MONTHS[start_month + month_increment]

      centered_month = "#{ this_month }".center(20) + '  '
      centered_month = centered_month.rstrip + "\n" if month_increment === 2
      month_header << centered_month

    #   if month_increment === 2
    #     month_header << "#{ this_month }".center(20).rstrip + "\n"
    #   else
    #     month_header << "#{ this_month }".center(20) + "  "
    #   end
    end

    month_header
  end

  def add_week_header
    header_string = day_header = 'Su Mo Tu We Th Fr Sa'

    2.times { header_string += "  #{day_header}" }
    header_string << "\n"
  end

  def add_weeks
    @week_array = ['', '', '', '', '', '']

    3.times do
      calendar_unit, @date = 1, 1
      create_weeks calendar_unit
      @month_counter += 1
    end

    @week_array.join
  end

  def create_weeks(calendar_unit)
    6.times do | week_position |
      @week = ''

      7.times do
        add_day calendar_unit
        calendar_unit += 1
      end
      month_counter % 3 === 0 ? @week = week.rstrip + "\n" : week << ' '

      @week_array[week_position] << week
    end
  end

  def add_day(calendar_unit)
    first_day = get_first_of_month
    blank_units = first_day == 0 ? 6 : first_day - 1
    month_length = get_month_length

    if calendar_unit <= blank_units || @date > month_length
      week << '   '
    elsif @date <= month_length
      (1..9).include?(@date) ? week << " #{ @date } " : week << "#{ @date } "
      @date += 1
    end
  end

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    m = month_values[month_counter - 1]
    y = (3..12).include?(month_counter) ? year : year - 1

    (1 + ((m * 26) / 10) + y + (y / 4) + (6 * (y / 100)) + (y / 400)) % 7
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]

    if months_with_31_days.include? month_counter
      31
    elsif months_with_30_days.include? month_counter
      30
    else
      year % 4 != 0 || year % 100 === 0 && year % 400 != 0 ? 28 : 29
    end
  end

end

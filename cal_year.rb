# require "ruby_cal"

class Year
  attr_reader :week, :month, :year, :calendar, :month_counter, :headers
  attr_reader :first_day, :blank_units, :month_length

  MONTHS = %w( January February March April May June July August September October November December )

  def initialize month_arg, year_arg = nil
    year_arg, month_arg = month_arg, nil if year_arg.nil?

    @calendar, @month_counter = "", 1
    @year = year_arg
    @month = month_arg
  end

  def render_year
    @first_day = first_day
    @blank_units = blank_units
    @month_length = month_length
    calendar << add_year_header
    start_month = 0
    4.times do
      calendar << add_three_month_header(start_month) << add_week_header << add_weeks
      start_month += 3
    end
    calendar
  end

  def add_year_header
    year.to_s.center(62).rstrip + "\n\n"
  end

  def add_three_month_header start_month
    month_header = ""
    3.times do | month_increment |
      this_month = MONTHS[start_month + month_increment]
      centered_month = "#{ this_month }".center(20) + "  "
      centered_month = centered_month.rstrip + "\n" if month_increment === 2
      month_header << centered_month
    end
    month_header
  end

  def add_week_header
    header_string = day_header = "Su Mo Tu We Th Fr Sa"
    2.times { header_string += "  #{day_header}" }
    header_string << "\n"
  end

  def add_weeks
    weeks, date, @week_array = "", "", [ "", "", "", "", "", "" ]
      3.times do
        calendar_unit, @day = 1, 1
        month_length = get_month_length
        loop_over_weeks_for_year calendar_unit
        @month_counter += 1
      end
    @week_array.join
  end

  def loop_over_weeks_for_year calendar_unit
    6.times do | week_position |
      @week = ""
      @day_counter = 0
      7.times do
       add_day calendar_unit
       calendar_unit += 1
       @day_counter += 1
      end
      format_week_for_year
      @week_array[week_position] << week
    end
  end

  def add_day calendar_unit
    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_month_length
    if calendar_unit <= blank_units or @day > month_length
      week << "   "
    elsif @day <= month_length
      (1..9).include?(@day) ? week << " #{ @day } " : week << "#{ @day } "
      @day += 1
    end
  end

  def format_week_for_year
    if @day_counter === 7
      month_counter % 3 === 0 ? @week = week.rstrip + "\n" : week << " "
    end
  end

  #pseudo - put month counter in cal.initialize. increment whenever get first_of_month is called - to move or not to move

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = month_values[month_counter - 1]
    adjusted_year = (3..12).include?(month_counter) ? year : year - 1
    (1 + ((adjusted_month * 26) / 10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year / 100)) + (adjusted_year / 400)) % 7
  end

  def get_blank_units first_day
    first_day == 0 ? 6 : first_day - 1
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]
    if months_with_31_days.include? month_counter
      31
    elsif months_with_30_days.include? month_counter
      30
    else
      (year % 4 != 0 or year % 100 === 0 && year % 400 != 0) ? 28 : 29
    end
  end

end

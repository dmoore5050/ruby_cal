
#to do? - split Month and Year into separate classes and call from Cal
class Cal
  attr_reader :month, :year, :months, :calendar, :headers
  attr_reader :MONTH_ERROR, :year_error
  MONTH_ERROR = "Valid months are 1..12, January..December"
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

  def initialize (month_arg, year_arg = nil) # Cal class
    year_arg, month_arg = month_arg, nil if year_arg.nil?

    @year_error = "Valid years are 1800..3000"
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
    raise ArgumentError, year_error unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i
  end

  def find_matching_month(month_arg)
   MONTHS.each_with_index do | the_month, index |
      if /^#{month_arg.downcase}/ =~ the_month.downcase
        @month = (index + 1)
        break
      end
    end
  end

  def print_calendar #split between classes
    @month_counter = 1
    @calendar = ""
    if month.nil?
      print_year
    else
      print_month
    end
    calendar
  end

  def print_year
    calendar << print_year_header
    first_month_in_row = 0
    4.times do
      calendar << print_month_header(first_month_in_row)
      calendar << print_week_header
      calendar << print_weeks
      first_month_in_row += 3
    end
  end

  def print_year_header # Year class
    uncentered_year = year.to_s.center(62).rstrip + "\n\n"
    uncentered_year
  end

  def print_month
    calendar << print_month_header
    calendar << print_week_header
    calendar << print_weeks
  end

  def print_month_header(first_month_in_row = nil) # split between classes
    if month.nil?
      print_three_month_header first_month_in_row
    else
      print_one_month_header
    end
  end

  def print_three_month_header(first_month_in_row)
    this_month, centered_month, month_header = "", "", ""
    3.times do | index |
      this_month =MONTHS[first_month_in_row + index]
      centered_month = "#{ this_month }".center(20) + "  "
      centered_month = centered_month.rstrip + "\n" if index === 2
      month_header << centered_month
    end
    month_header
  end

  def print_one_month_header
    this_month, centered_string = "", ""
    this_month = MONTHS[month - 1]
    centered_string = "#{ this_month } #{ year }".center(20).rstrip
    centered_string + "\n"
  end

  def print_week_header # split between classes
    unless month.nil?
      "Su Mo Tu We Th Fr Sa\n"
    else
      "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n"
    end
  end

  def print_weeks # split between classes
    if month.nil?
      print_weeks_for_year
    else
      print_weeks_for_single_month
    end
  end

  def print_weeks_for_year
    weeks, date = "", ""
    @week_array = [ "", "", "", "", "", "" ]
    3.times do
      calendar_unit = 1
      @day = 1
      month_length = get_month_length
      loop_over_weeks_for_year calendar_unit
      @month_counter += 1
    end
    @week_array.join
  end

  def loop_over_weeks_for_year(calendar_unit)
    6.times do | index |
      @week = ""
      @day_counter = 0
      7.times do
        print_day calendar_unit
        calendar_unit += 1
        @day_counter += 1
      end
      format_week_for_year
      @week_array[index] << @week
    end
  end

  def print_weeks_for_single_month
    weeks, date = "", ""
    calendar_unit = 1
      @day = 1
      month_length = get_month_length
      6.times do
        @week = ""
        7.times do
          print_day calendar_unit
          format_day_for_month calendar_unit, month_length
          calendar_unit += 1
        end
        weeks << @week
      end
    weeks
  end

  def print_day (calendar_unit) # Cal class perhaps? unsure.
    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_month_length
    if calendar_unit <= blank_units
      @week << "   "
    elsif @day <= month_length
      date = (1..9).include?(@day) ? " #{ @day } " : "#{ @day } "
      @week << date
      @day += 1
    elsif month.nil? && @day > month_length
      @week << "   "
    end
  end

  def format_week_for_year # year class
    if @day_counter === 7
      if @month_counter % 3 === 0
        @week = @week.rstrip
        @week << "\n"
      else
        @week << " "
      end
    end
  end

  def format_day_for_month calendar_unit, month_length # month class
    if calendar_unit % 7 === 0
      @week = @week.rstrip
      @week << "\n"
    end
  end

  def get_first_of_month # Cal class
    # return 0/sat, 1/sun, 2/mon ... 6/friday
    month_index = month.nil? ? @month_counter : month
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = month_values[month_index - 1]
    adjusted_year = (3..12).include?(month_index) ? year : year - 1
    (1 + ((adjusted_month * 26) / 10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year / 100)) + (adjusted_year / 400)) % 7
  end

  def get_blank_units (first_day) # Cal class
    first_day == 0 ? 6 : first_day - 1
  end

  def get_month_length
    month_comp = month.nil? ? @month_counter : month
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]
    if months_with_31_days.include? month_comp
      31
    elsif months_with_30_days.include? month_comp
      30
    else
      if year % 4 != 0 or year % 100 === 0 && year % 400 != 0
        28
      else
        29
      end
    end
  end

end

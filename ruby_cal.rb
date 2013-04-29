class Cal
  attr_accessor :month
  attr_accessor :year

  @month_error = "Valid months are 1..12"
  @year_error = "Valid years are 1800..3000"

  def initialize (month, year)
    raise ArgumentError, @month_error unless (1..12).include? month
    raise ArgumentError, @year_error unless (1800..3000).include? year
    @month = month
    @year = year

  end

  def print_calendar

    calendar = ""
    calendar << print_month_header
    calendar << print_days_header
    calendar << print_weeks

    calendar
  end

  def print_month_header

    months = [ "January",
               "February",
               "March",
               "April",
               "May",
               "June",
               "July",
               "August",
               "September",
               "October",
               "November",
               "December"
             ]
    this_month = months[ month - 1 ]
    uncentered_string = "#{this_month} #{year}"
    centered_string = uncentered_string.center(20).rstrip

    return centered_string + "\n"
  end

  def print_days_header
    return "Su Mo Tu We Th Fr Sa\n"
  end

  def print_weeks

    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_days_in_month
    unit, day, weeks, date = 1, 1, "", ""

    42.times do
      if unit <= blank_units
        weeks << "  "
      elsif day <= month_length
        date = (1..9).include?(day) ? " #{day}" : "#{day}"
        weeks << date
        day += 1
      end
      if unit % 7 == 0
        weeks << "\n"
      elsif day <= month_length
        weeks << " "
      end
      unit += 1
    end
    weeks
  end

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday

    months = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = months[month - 1]

    adjusted_year = (3..12).include?(month) ? year : year - 1

    start_day = (1 + ((adjusted_month * 26)/10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year/100)) + (adjusted_year/400)) % 7
  end

  def get_blank_units (first_day)

    blank_units = first_day == 0 ? 6 : first_day - 1

  end

  def get_days_in_month

    if [1,3,5,7,8,10,12].include? month
      31
    elsif [4,6,9,11].include? month
      30
    else
      if (year % 4 != 0) or ((year % 100 == 0) and (year % 400 != 0))
        28
      else
        29
      end
    end
  end

end














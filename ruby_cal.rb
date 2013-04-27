# month = ARGV[0]
# year = ARGV[1]

# calendar = Cal.new month, year
# calendar.print_calendar#

# puts `cal #{month} #{year}`

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
    raise ArgumentError, @month_error unless (1..12).include? month
    raise ArgumentError, @year_error unless (1800..3000).include? year

    calendar = ""
    calendar << print_month_header
    calendar << print_days_header
    calendar << print_weeks

    calendar
  end

  def print_month_header
    raise ArgumentError, @month_error unless (1..12).include? month
    raise ArgumentError, @year_error unless (1800..3000).include? year

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
    raise ArgumentError, @month_error unless (1..12).include? month
    raise ArgumentError, @year_error unless (1800..3000).include? year

    first_day = get_first_of_month
    initial_spaces = get_initial_spaces first_day
    days_number = get_days_in_month
    units_counter = 1
    days_counter = 1
    weeks = ""

    6.times do
      7.times do
        if units_counter <= initial_spaces
          weeks << "  "
        elsif units_counter >= initial_spaces and days_counter <= days_number
          if (1..9).include? days_counter
            weeks << " #{days_counter}"
          elsif days_counter <= days_number
            weeks << "#{days_counter}"
          end
          days_counter += 1
        end
        if units_counter % 7 == 0
          weeks << "\n"
        elsif days_counter <= days_number
          weeks << " "
        end
        units_counter += 1
      end
    end

    weeks
  end

  def get_first_of_month
    raise ArgumentError, @month_error unless (1..12).include? month
    raise ArgumentError, @year_error unless (1800..3000).include? year
    # return 0/sat, 1/sun, 2/mon ... 6/friday

    months = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = months[ month - 1 ]

    if (3..12).include? month
      adjusted_year = year
    else
      adjusted_year = year - 1
    end

    start_day = (1 + ((adjusted_month * 26)/10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year/100)) + (adjusted_year/400)) % 7
  end

  def get_initial_spaces (first_day)

    if first_day == 0
      spaces_count = 6
    else
      spaces_count = first_day - 1
    end
  end

  def get_days_in_month
    raise ArgumentError, @month_error unless (1..12).include? month

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














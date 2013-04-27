  # month = ARGV[0]
  # year = ARGV[1]

  # puts `cal #{month} #{year}`

class Cal
  attr_accessor :month
  attr_accessor :year

  def initialize (month, year)
    @month = month
    @year = year
  end

  def print_calendar

    calendar_string = ""
    calendar_string << print_month_header
    calendar_string << print_days_header

    calendar_string
  end

  def print_month_header
    raise ArgumentError unless (1..12).include? month
    raise ArgumentError unless (1800..3000).include? year

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
    uncentered_string = "#{this_month} #{year}\n"

    return uncentered_string.center(20)
  end

  def print_days_header
    return "Su Mo Tu We Th Fr Sa\n"
  end

  def get_first_of_month
    raise ArgumentError unless (1..12).include? month
    raise ArgumentError unless (1800..3000).include? year
    # return 0/sat, 1/sun, 2/mon ... 6/friday

    months = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    month_num = months[ month - 1 ]

    if (3..12).include? month
      year_num = year
    else
      year_num = year - 1
    end

    start_day = (1 + ((month_num * 26)/10) + year_num + (year_num/4) + (6 * (year_num/100)) + (year_num/400)) % 7
  end

  def find_weeks_number
    raise ArgumentError unless (1..12).include? month
    raise ArgumentError unless (1800..3000).include? year
  end

  def format_month
    raise ArgumentError unless (1..12).include? month
    raise ArgumentError unless (1800..3000).include? year
  end

end
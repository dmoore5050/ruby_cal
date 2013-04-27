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

class Cal
  attr_reader :month
  attr_reader :year
  attr_reader :months
  attr_reader :month_error
  attr_reader :year_error

  @month_error = "Valid months are 1..12, January..December"
  @year_error = "Valid years are 1800..3000"

  def initialize (month_arg, year_arg = nil)

    year_arg, month_arg = month_arg, nil if year_arg.nil?

    @months = [ "January",
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

    @month = month_arg

    month_arg = month_arg.to_i if month_arg =~ /^[-+]?[1-9]([0-9]*)?$/

    if month_arg.class.name === "String" && month_arg.size >= 3
      unless months.find { |e| /^#{month_arg.downcase}/ =~ e.downcase }
        raise NameError, month_error
      end
      #months.include? month_arg.capitalize
      i = 0
      months.each_with_index do | this_month, index |
        if /^#{month_arg.downcase}/ =~ this_month.downcase
          month_arg = (index + 1)
          break
        end
      end
    elsif month_arg.class.name === "Fixnum"
      raise ArgumentError, month_error unless (1..12).include? month_arg
    elsif month_arg.class.name == "NilClass"
      @month = nil
    else
      raise ArgumentError, month_error
    end
    @month = month_arg

    raise ArgumentError, year_error unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i

  end

  def print_calendar

    calendar = ""
    unless month.nil?
      calendar << print_month_header
      calendar << print_days_header
      calendar << print_weeks
    else
      calendar << print_year_header
      month_start = 0
      4.times do
        calendar << print_month_header(month_start)
        calendar << print_days_header
        month_start += 3
      end
    end

    calendar
  end

  def print_year_header
    uncentered_year = year.to_s.center(62).rstrip + "\n\n"
    uncentered_year
  end

  def print_month_header(month_start = nil)#(*month_start)

    if month === nil
      month_header, centered_month, uncentered_month = "", "", ""
      # month_header = ""
      3.times do | index |
        this_month = @months[month_start + index]
        uncentered_month = "#{this_month}"
        centered_month = uncentered_month.center(20) + "  "
        if index == 2
          centered_month = centered_month.rstrip + "\n"
        end
        month_header << centered_month
      end
      month_header
    else
      this_month = months[ month - 1 ]
      uncentered_string = "#{this_month} #{year}"
      centered_string = uncentered_string.center(20).rstrip

      centered_string + "\n"
    end

  end

  def print_days_header
    if month != nil
      "Su Mo Tu We Th Fr Sa\n"
    else
      "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n"
    end
  end

  def print_weeks

    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_days_in_month
    day, unit, weeks, date = 1, 1, "", ""

    6.times do | weeks_count |
      7.times do
        if (unit) <= blank_units
          weeks << "  "
        elsif day <= month_length
          date = (1..9).include?(day) ? " #{day}" : "#{day}"
          weeks << date
          day += 1
        end
        if (unit) % 7 == 0
          weeks << "\n"
        elsif day <= month_length
          weeks << " "
        end
        unit += 1
      end
    end
    weeks
  end

  def get_first_of_month
    # return 0/sat, 1/sun, 2/mon ... 6/friday

    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = month_values[month - 1]

    adjusted_year = (3..12).include?(month) ? year : year - 1

    start_day = (1 + ((adjusted_month * 26)/10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year/100)) + (adjusted_year/400)) % 7
  end

  def get_blank_units (first_day)

    blank_units = first_day == 0 ? 6 : first_day - 1

  end

  def get_days_in_month

    months_with_31_days = [1,3,5,7,8,10,12]
    months_with_30_days = [4,6,9,11]

    if months_with_31_days.include? month
      31
    elsif months_with_30_days.include? month
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


#to do - once year code is written, split Month and Year into separate classes and call from Cal
class Cal
  attr_reader :month
  attr_reader :year
  attr_reader :months
  attr_reader :month_error
  attr_reader :year_error

  @month_error = "Valid months are 1..12, January..December"
  @year_error = "Valid years are 1800..3000"

  def initialize (month_arg, year_arg = nil) # Cal class

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

    month_arg = month_arg.to_i if month_arg =~ /^[0-9]([0-9]*)?$/

    if month_arg.class.name === "String" && month_arg.size >= 3
      unless months.find { |month| /^#{month_arg.downcase}/ =~ month.downcase }
        raise NameError, month_error
      end
      i = 0
      months.each_with_index do | month, index |
        if /^#{month_arg.downcase}/ =~ month.downcase
          month_arg = (index + 1)
          break
        end
      end
    elsif month_arg.class.name === "Fixnum"
      raise ArgumentError, month_error unless (1..12).include? month_arg
    elsif month_arg.class.name === "NilClass"
      @month = nil
    else
      raise ArgumentError, month_error
    end
    @month = month_arg

    raise ArgumentError, year_error unless (1800..3000).include? year_arg.to_i
    @year = year_arg.to_i

  end

  def print_calendar #split between classes

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
        calendar << print_weeks
        month_start += 3
      end
    end

    calendar
  end

  def print_year_header # Year class
    uncentered_year = year.to_s.center(62).rstrip + "\n\n"
    uncentered_year
  end

  def print_month_header(month_start = nil) # split between classes

    if month === nil
      month_header, centered_month, uncentered_month = "", "", ""
      3.times do | index |
        this_month = @months[month_start + index]
        uncentered_month = "#{this_month}"
        centered_month = uncentered_month.center(20) + "  "
        centered_month = centered_month.rstrip + "\n" if index == 2
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

  def print_days_header # split between classes
    if month != nil
      "Su Mo Tu We Th Fr Sa\n"
    else
      "Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n"
    end
  end

  def print_weeks # split between classes

    @day, cal_unit, weeks, date = 1, 1, "", ""
    @week_array = [ "", "", "", "", "", "" ]

    if month === nil
      @month_counter = 1
      3.times do
        month_length = get_days_in_month
        6.times do | week_counter |
          @week = ""
          @day_counter = 0
          7.times do
            print_day cal_unit
            @week << " " if @day <= month_length
            cal_unit += 1
            @day_counter += 1
          end
            format_week_for_year
            @week_array[ week_counter ] << @week
        end
        @month_counter += 1
      end

      @week_array.join
    else
      month_length = get_days_in_month

      6.times do
        @week = ""
        7.times do
          print_day cal_unit
          format_day_for_month cal_unit, month_length
          cal_unit += 1
        end
        weeks << @week
      end
      weeks
    end
  end

  def print_day (cal_unit) # Cal class perhaps? unsure.

    first_day = get_first_of_month
    blank_units = get_blank_units first_day
    month_length = get_days_in_month

    if cal_unit <= blank_units
      @week << "  "
    elsif @day <= month_length
      date = (1..9).include?(@day) ? " #{@day}" : "#{@day}"
      @week << date
      @day += 1
    end
  end

  def format_day_for_month cal_unit, month_length # month class
    if cal_unit % 7 === 0
      @week << "\n"
    elsif @day <= month_length
      @week << " "
    end
  end

  def format_week_for_year # week class #NOT WORKING
    if @day_counter == 7
      @month_counter % 3 === 0 ? @week << "\n" : @week << " "
    end
  end

  def get_first_of_month # Cal class
    # return 0/sat, 1/sun, 2/mon ... 6/friday

    month_index = month === nil ? @month_counter : month

    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    adjusted_month = month_values[month_index - 1]

    adjusted_year = (3..12).include?(month_index) ? year : year - 1

    (1 + ((adjusted_month * 26)/10) + adjusted_year + (adjusted_year/4) + (6 * (adjusted_year/100)) + (adjusted_year/400)) % 7
  end

  def get_blank_units (first_day) # stay in Cal class

    first_day == 0 ? 6 : first_day - 1

  end

  def get_days_in_month

    month_comp = month === nil ? @month_counter : month

    months_with_31_days = [1,3,5,7,8,10,12]
    months_with_30_days = [4,6,9,11]

    if months_with_31_days.include? month_comp
      31
    elsif months_with_30_days.include? month_comp
      30
    else
      if (year % 4 != 0) or ((year % 100 === 0) and (year % 400 != 0))
        28
      else
        29
      end
    end
  end

end

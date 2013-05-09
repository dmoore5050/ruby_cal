# Encoding: UTF-8

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

# Month class is what builds the days, months, and weeks of the calendar.
# The process determines whether the month is a part of the Gregorian or
# Julian  calendar, and uses Zeller's Congruence and a pair of loops to
# produce each month. September 1752 is produced in literal form rather than
# systematically due to its unique composition.

class Month

  def initialize(month_arg, year_arg)
    @month, @year = month_arg, year_arg

    set_calendar_type
  end

  def set_calendar_type

    if @year < 1752 || @year === 1752 && @month < 9
      @calendar_type = 'Julian'
    elsif @year > 1753 || @year === 1752 && @month > 9
      @calendar_type = 'Gregorian'
    else @calendar_type = 'September 1752'
    end

  end


  def render_month(year_trigger = nil)
    @calendar, @year_trigger = '', year_trigger
    @calendar << add_month_head << add_week_head << add_weeks
  end

  # 'X' is abitrarily used in the following methods to mark the point at which
  # the Year.build_months method will split and reformat the rendered months.

  def add_month_head
    this_month = MONTHS[@month - 1]
    if @year_trigger.nil?
      "#{ this_month } #{ @year }".center(20).rstrip + "\n"
    else
      "#{ this_month }".center(20) + ' X'
    end
  end

  def add_week_head
    @year_trigger.nil? ? "Su Mo Tu We Th Fr Sa\n" : 'Su Mo Tu We Th Fr Sa X'
  end

  def add_weeks
    if @calendar_type ==='September 1752' && @year_trigger.nil?
      "       1  2 14 15 16\n17 18 19 20 21 22 23\n24 25 26 27 28 29 30\n\n\n\n"
    elsif @calendar_type ==='September 1752'
      '       1  2 14 15 16 X17 18 19 20 21 22 23 X24 25 26 27 28 29 30 X X X X'
    else
      weeks, @calendar_unit, @date = '', 1, 1

      6.times do
        build_week
        weeks << @week
      end

      weeks
    end
  end

  def build_week
    @week = ''
    7.times do
      build_day

      if @calendar_unit % 7 === 0
        @week = @week.rstrip + "\n" if @year_trigger.nil?
        @week << 'X' unless @year_trigger.nil?
      end
      @calendar_unit += 1
    end
  end

  def build_day
    first_day = get_first_of_month
    blank_units = first_day === 0 ? 6 : first_day - 1
    month_length = get_month_length

    if @date > month_length || @calendar_unit <= blank_units
      @week << '   '
    elsif @date <= month_length
      (1..9).include?(@date) ? @week << " #{ @date } " : @week << "#{ @date } "
      @date += 1
    end
  end

  def get_first_of_month
    # returns 0/sat, 1/sun, 2/mon ... 6/friday
    month_values = [14, 15, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    m = month_values[@month - 1]
    y = (3..12).include?(@month) ? @year : @year - 1

    # Zeller's Congruence: en.wikipedia.org/wiki/zeller's_congruence
    case @calendar_type
    when 'Julian' then (1 + ((m * 26) / 10) + y + (y / 4) + 5) % 7
    when 'Gregorian'
      (1 + ((m * 26) / 10) + y + (y / 4) + (6 * (y / 100)) + (y / 400)) % 7
    end
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]

    case
    when (months_with_31_days.include? @month) then 31
    when (months_with_30_days.include? @month) then 30
    when @calendar_type === 'Julian' then @year % 4 === 0 ? 29 : 28
    when @calendar_type === 'Gregorian'
        @year % 4 != 0 || @year % 100 === 0 && @year % 400 != 0 ? 28 : 29
    end

  end

end

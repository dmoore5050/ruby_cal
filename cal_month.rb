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

class Month

  def initialize(month_arg, year_arg)
    @month, @year = month_arg, year_arg

    set_calendar_type
  end

  def set_calendar_type
    case
    when @year < 1752 then @calendar_type = 'Julian'
    when @year > 1753 then @calendar_type = 'Gregorian'
    when @year === 1752
      case
      when @month < 9 then @calendar_type = 'Julian'
      when @month > 9 then @calendar_type = 'Gregorian'
      end
    end
  end

  def render_month(year_trigger = nil)
    @calendar, @year_trigger = '', year_trigger
    @calendar << add_month_head << add_week_head << add_weeks
  end

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
    if @month === 9 && @year === 1752 && @year_trigger.nil?
      "       1  2 14 15 16\n17 18 19 20 21 22 23\n24 25 26 27 28 29 30\n\n\n\n"
    elsif @month === 9 && @year === 1752
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
      if @year_trigger.nil?
        @week = @week.rstrip + "\n" if @calendar_unit % 7 === 0
      else
        @week = @week + 'X' if @calendar_unit % 7 === 0
      end
      @calendar_unit += 1
    end
  end

  def build_day
    first_day = get_first_of_month
    blank_units = first_day === 0 ? 6 : first_day - 1
    month_length = get_month_length

    if @calendar_unit <= blank_units || @date > month_length
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
    if @calendar_type === 'Gregorian'
      (1 + ((m * 26) / 10) + y + (y / 4) + (6 * (y / 100)) + (y / 400)) % 7
    elsif @calendar_type === 'Julian'
      (1 + ((m * 26) / 10) + y + (y / 4) + 5) % 7
    end
  end

  def get_month_length
    months_with_31_days = [1, 3, 5, 7, 8, 10, 12]
    months_with_30_days = [4, 6, 9, 11]

    case
    when (months_with_31_days.include? @month) then 31
    when (months_with_30_days.include? @month) then 30
    else
      if @calendar_type === 'Gregorian'
        @year % 4 != 0 || @year % 100 === 0 && @year % 400 != 0 ? 28 : 29
      elsif @calendar_type === 'Julian'
        @year % 4 === 0 ? 29 : 28
      end
    end
  end

end

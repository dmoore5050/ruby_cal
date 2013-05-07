# Encoding: UTF-8

require_relative 'cal_month'

class Year

  attr_reader :year, :calendar, :month_counter, :year_trigger

  def initialize(year_arg)
    @calendar, @month_counter, @year = '', 1, year_arg
    @year_trigger = 0
  end

  def render_year
    calendar << add_year_head
    start_month = 0
    4.times do
      calendar << add_month_head(start_month) << add_week_head << build_months
      start_month += 3
    end

    calendar
  end

  def add_year_head
    year.to_s.center(62).rstrip + "\n\n"
  end

  def add_month_head(start_month)
    month_header = ''

    3.times do | month_increment |
      this_month = MONTHS[start_month + month_increment]

      if month_increment === 2
        month_header << "#{ this_month }".center(20).rstrip + "\n"
      else
        month_header << "#{ this_month }".center(20) + '  '
      end
    end

    month_header
  end

  def add_week_head
    header_string = day_header = 'Su Mo Tu We Th Fr Sa'

    2.times { header_string += "  #{day_header}" }
    header_string << "\n"
  end

  def build_months
    @week_array = ['', '', '', '', '', '']

    3.times do
      new_month = Month.new @month_counter, year
      rendered_weeks = new_month.add_weeks(year_trigger).split("\n")
      rendered_weeks.each_with_index do | week, i |
        format_weeks week, i
      end
      @month_counter += 1
    end
    @week_array.join
  end

  def format_weeks(week, i)
    if @month_counter % 3 === 0
      @week_array[i] << week.rstrip + "\n"
    else
      @week_array[i] << week + ' '
    end
  end

end


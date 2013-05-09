# Encoding: UTF-8

require_relative 'cal_month'

# The year class utilizes the Month class to build a year, reformatting
# the months outputted to render a 12-month calendar.

class Year

  def initialize(year_arg)
    @year = year_arg
  end

  def render_year
    @month_counter, @calendar = 1, ''
    @calendar << build_year_header
    4.times do
      @calendar << build_months
    end

    @calendar
  end

  def build_year_header
    if @year < 1000
      header_year = " #{@year}"
    else
      header_year = @year
    end

    header_year.to_s.center(62).rstrip + "\n\n"
  end

  def build_months
    @week_array, year_trigger = ['', '', '', '', '', '', '', ''], 'Active'

    3.times do
      new_month = Month.new @month_counter, @year
      rendered_weeks = new_month.render_month(year_trigger).split('X')
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

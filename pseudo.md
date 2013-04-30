
@day, unit, weeks, date = 1, 1, "", ""
@week_array = [ "", "", "", "", "", "" ]
month_length = get_days_in_month

  6.times do
    @week = ""
    7.times do
      print_day unit
      format_week_for_month unit, month_length
      unit += 1
    end
    weeks << @week
  end
  weeks

pseudo
  Loop over 3 months. For every month:
    Loop over 6 weeks. For every week:
      initiate week
      Loop over 7 days. For every day:
        print day or blank spaces (print_day) --working
        add space after day
        increment day counter --working
        push days into a week
      end #day loop
      format week - written
      push week into position in weeks array -written
    end # week loop
  end # month loop




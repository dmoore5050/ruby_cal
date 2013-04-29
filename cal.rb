require_relative 'ruby_cal'

year = ARGV[1]
month = ARGV[0]

calendar = Cal.new month, year
puts calendar.print_calendar

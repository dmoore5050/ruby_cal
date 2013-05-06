# Encoding: utf-8

require_relative 'ruby_cal'

month = ARGV[0]
year = ARGV[1]

calendar = Cal.new month, year
puts calendar.print_calendar

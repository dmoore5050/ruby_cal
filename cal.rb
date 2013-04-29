require_relative 'ruby_cal'

year = ARGV[1].to_i
month = ARGV[0]

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

#ternary or if/else?
# month = ARGV[0] =~ /^[-+]?[1-9]([0-9]*)?$/ ? ARGV[0].to_i : month = ARGV[0]
if ARGV[0] =~ /^[-+]?[1-9]([0-9]*)?$/
  month = ARGV[0].to_i
else
  month = ARGV[0]
end

calendar = Cal.new month, year
puts calendar.print_calendar

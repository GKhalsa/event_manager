require 'date'
require 'csv'

contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol
total_hours = []

contents.each do |row|
  date_and_time = row[:regdate]
  times = DateTime.strptime(date_and_time, '%m/%d/%Y %H:%M').to_time.utc
  hours = times.hour
  total_hours << hours.to_s.rjust(2,'0')
end

paired = {}

total_hours.each do |a|
  if paired[a].nil?
    paired[a] = 1
  else
    paired[a] += 1
  end
end

array = []

paired.map do |hour,occurances|
  array << ["#{hour}:00 - #{occurances}"]
end

puts array.sort

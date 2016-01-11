require 'csv'

class Number
  attr_reader :shiieeettt

  def initialize
    @shiieeettt ||= CleanNumber.new
  end

  def contents
    CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol
  end

  def numbers
    contents.each do |row|
      number = row[:homephone].gsub(/\D/, "")
      num = shiieeettt.cleaner(number)
    end
  end
end

class CleanNumber
  def cleaner(lolol)
    if lolol.length < 10 || lolol.length > 11
      puts 'no number'
    elsif lolol.length == 11 && lolol[0] == '1'
      puts lolol[1..-1]
    elsif lolol.length == 11 && lolol[0] != '1'
      puts 'no number'
    else
      puts lolol
    end
  end
end

puts Number.new.numbers

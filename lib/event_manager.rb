require 'csv'
require 'pry'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

puts "Event Manager Initialized!"

def clean_zipcode(zipcode)
  zipcode = zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  # legislator_names = legislators.map do |legislator|
  #   "#{legislator.first_name} #{legislator.last_name}"
  # end
  # legislator_names.join(", ")
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"
  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
    puts form_letter
  end
end

def clean_homephone(number)
  if number.length < 10 || number.length > 11
    puts 'no number'#number.gsub(/\d/, '0')
  elsif number.length == 11 && number[0] == '1'
    puts number[1..-1]
  elsif number.length == 11 && number[0] != '1'
    puts 'no number'
  else
    puts number
  end
end


contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "../form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  number = clean_homephone(row[:homephone].gsub(/\D/, ""))

  # personal_letter = template_letter.gsub('FIRST_NAME',name)
  # personal_letter.gsub!('LEGISLATORS',legislators)
  # form_letter = erb_template.result(binding)
  # save_thank_you_letters(id,form_letter)

   puts number
  
end

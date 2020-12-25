def validate_boarding_pass(pass)
  m = /^(?<row>[FB]{7})(?<column>[LR]{3})$/.match(pass)
  return m["row"], m["column"]
end

def calculate_row_number(row_text)
  row_text.gsub("F","0").gsub("B","1").to_i(2)
end

def calculate_column_number(column_text)
  column_text.gsub("L","0").gsub("R","1").to_i(2)
end

# Load all lines into list
lines = File.readlines("input.txt")

seat_ids = lines.map do |boarding_pass|
  row_text,column_text = validate_boarding_pass(boarding_pass)

  row_number = calculate_row_number(row_text)
  column_number = calculate_column_number(column_text)
  seat_id = row_number * 8 + column_number

  puts "row #{row_number}, column #{column_number}, seat ID #{seat_id}"
  seat_id
end
puts seat_ids.max

puts "range: [#{seat_ids.min},#{seat_ids.max}]"

(seat_ids.min..seat_ids.max).each do |n|
  if !seat_ids.include?(n) then
    puts "Found: #{n}"
  end 
end
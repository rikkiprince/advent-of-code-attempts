# Load all lines into list
lines = File.readlines("input.txt")

number_of_valid_passwords = 0
lines.each do |line|
    m = /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]]): ([[:alpha:]]+)/.match(line)
    first_position = m[1].to_i
    second_position = m[2].to_i
    character = m[3]
    password = m[4]
    if (password[first_position-1] == character) ^ (password[second_position-1] == character) then
        number_of_valid_passwords += 1
    end
end

puts "Number of valid passwords: #{number_of_valid_passwords}"
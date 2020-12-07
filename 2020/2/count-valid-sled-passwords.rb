# Load all lines into list
lines = File.readlines("input.txt")

number_of_valid_passwords = 0
lines.each do |line|
    m = /([[:digit:]]+)-([[:digit:]]+) ([[:alpha:]]): ([[:alpha:]]+)/.match(line)
    minimum = m[1].to_i
    maximum = m[2].to_i
    character = m[3]
    password = m[4]
    if password.count(character).between?(minimum, maximum) then
        number_of_valid_passwords += 1
    end
end

puts "Number of valid passwords: #{number_of_valid_passwords}"
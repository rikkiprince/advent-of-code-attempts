def get_hash_from_input(lines)
  lines
    .chunk { |line|
      line == "\n"
    }
    .select { |blank, collection_of_lines|
      collection_of_lines != ["\n"]
    }
    .map { |blank, collection_of_lines|
      collection_of_lines.map(&:chomp).join(" ").split(" ").map { |pair|
        s = pair.split(":")
        { s[0] => s[1] }
      }.reduce Hash.new, :merge
    }
end

def are_fields_present(passport)
  ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? { |field|
    if !passport.has_key?(field) then
      # puts "missing #{field}"
      return false
    end
    true
  }
end

def height_is_valid(passport)
  m = /([[:digit:]]+)(cm|in)/.match(passport["hgt"])
  return false if !m
  units = m[2]
  height = m[1].to_i
  if units == "cm" then
    return height.between?(150,193)
  elsif units == "in" then
    return height.between?(59,76)
  else
    # puts "height is invalid"
    return false
  end
end

def year_is_valid(passport, key, start_year, end_year)
  return false if passport[key].nil?
  if passport[key] =~ /^[[:digit:]]{4}$/ && passport[key].to_i.between?(start_year,end_year) then
    return true
  else
    # puts "#{key} invalid: #{passport[key]}"
    return false
  end
end

def hair_colour_is_valid(passport)
  passport["hcl"] =~ /^#[[:xdigit:]]{6}$/
end

def eye_colour_is_valid(passport)
  ["amb","blu","brn","gry","grn","hzl","oth"].include?(passport["ecl"])
end

def passport_id_is_valid(passport)
  passport["pid"] =~ /^[[:digit:]]{9}$/
end

def data_is_valid(passport)
  return (year_is_valid(passport, "byr", 1920,2002) &&
          year_is_valid(passport, "iyr", 2010,2020) &&
          year_is_valid(passport, "eyr", 2020,2030) &&
          height_is_valid(passport) &&
          hair_colour_is_valid(passport) &&
          eye_colour_is_valid(passport) &&
          passport_id_is_valid(passport)
  )
end

# Load all lines into list
lines = File.readlines("input.txt")
passports = get_hash_from_input(lines)
puts "Total: #{passports.count()}"

number_of_passports_with_correct_fields = passports.filter { |passport|
  are_fields_present(passport)
}.count()
puts "Correct fields present: #{number_of_passports_with_correct_fields}"

number_of_passports_with_valid_data = passports.filter { |passport|
  are_fields_present(passport) && data_is_valid(passport)
}.count()
puts "Valid: #{number_of_passports_with_valid_data}"
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

class Passport
  def initialize(passport_hash)
    @passport = passport_hash
  end

  def are_fields_present
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? { |field|
      if !@passport.has_key?(field) then
        # puts "missing #{field}"
        return false
      end
      true
    }
  end

  def height_is_valid
    m = /([[:digit:]]+)(cm|in)/.match(@passport["hgt"])
    return false if !m
    units = m[2]
    height = m[1].to_i
    if units == "cm" then
      return height.between?(150,193)
    elsif units == "in" then
      return height.between?(59,76)
    else
      return false
    end
  end

  def hair_colour_is_valid
    @passport["hcl"] =~ /^#[[:xdigit:]]{6}$/
  end
  
  def eye_colour_is_valid
    ["amb","blu","brn","gry","grn","hzl","oth"].include?(@passport["ecl"])
  end
  
  def passport_id_is_valid
    @passport["pid"] =~ /^[[:digit:]]{9}$/
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

def data_is_valid(passport, p)
  return (year_is_valid(passport, "byr", 1920,2002) &&
          year_is_valid(passport, "iyr", 2010,2020) &&
          year_is_valid(passport, "eyr", 2020,2030) &&
          p.height_is_valid &&
          p.hair_colour_is_valid &&
          p.eye_colour_is_valid &&
          p.passport_id_is_valid
  )
end

# Load all lines into list
lines = File.readlines("input.txt")
passports = get_hash_from_input(lines)
puts "Total: #{passports.count()}"

number_of_passports_with_correct_fields = passports.filter { |passport|
  p = Passport.new(passport)
  p.are_fields_present
}.count()
puts "Correct fields present: #{number_of_passports_with_correct_fields}"

number_of_passports_with_valid_data = passports.filter { |passport|
  p = Passport.new(passport)
  p.are_fields_present && data_is_valid(passport, p)
}.count()
puts "Valid: #{number_of_passports_with_valid_data}"
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

def is_passport_valid(passport)
  ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? { |field|
    passport.has_key?(field)
  }
end

# Load all lines into list
lines = File.readlines("input.txt")
passports = get_hash_from_input(lines)
number_of_valid_passports = passports.filter { |passport|
  is_passport_valid(passport)
}.count()

puts number_of_valid_passports
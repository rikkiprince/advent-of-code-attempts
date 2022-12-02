def test(hex, answer, expected_answer)
  if !expected_answer.nil?
    if expected_answer == answer
      puts "SUCCESS (#{answer} == #{expected_answer}) - #{hex}"
    else
      puts "FAILURE (#{answer} != #{expected_answer}) - #{hex}"
    end
  else
    puts "ANSWER #{answer} - #{hex}"
  end
  puts "-------"
end

def read_hex(file_name)
  lines = File.readlines(file_name)
  lines.first.chomp
end

def left_pad_to_multiple_of_4(s)
  s.rjust(s.length + (4-s.length)%4, "0")
end

def extract_full_literal_value(binary)
  s = ""
  literal_binary = ""
  prefix = "-1"
  until prefix.to_i == 0
    prefix = binary.slice!(0)
    value = binary.slice!(0..3)
    s += prefix + value
    literal_binary += value
  end
  puts "#{literal_binary} = #{literal_binary.to_i(2)}"
  more_to_pad = (4-s.length)%4
  s += binary.slice!(0..more_to_pad-1) if more_to_pad > 0

  return s, binary
end

LITERAL_VALUE = 4
def read_packet(binary)
  version = binary.slice!(0..2).to_i(2)
  type = binary.slice!(0..2).to_i(2)
  puts "v#{version} t#{type}"
  case type
  when LITERAL_VALUE
    literal, binary = extract_full_literal_value(binary)
  else # OPERATOR
  end
end

def calculate(hex, expected_version_sum=nil)
  binary = left_pad_to_multiple_of_4(hex.to_i(16).to_s(2))
  read_packet(binary)
  version_sum = 0
  test(hex, version_sum, expected_version_sum)
end

calculate("D2FE28") # literal, 2021
# calculate("38006F45291200") # operator, 10, 20
# calculate("EE00D40C823060") # operator, 1, 2, 3
# calculate("8A004A801A8002F478", 16)
# calculate("620080001611562C8802118E34", 12)
# calculate("C0015000016115A2E0802F182340", 23)
# calculate("A0016C880162017C3686B18A3D4780", 31)
# calculate(read_hex("input.txt"))

puts extract_full_literal_value("01111000") == ["01111000",""]
puts extract_full_literal_value("011110001") == ["01111000","1"]
puts extract_full_literal_value("111110111100") == ["111110111100",""]
puts extract_full_literal_value("11111011110011111") == ["111110111100","11111"]
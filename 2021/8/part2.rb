def decipher(inputs)
  lookup = {}
  one = ""
  four = ""

  unknown, known = inputs.partition {|i| [5,6].include?(i.length)}

  known.each do |input|
    input = input.chars.sort.join
    case input.length
    when 2
      lookup[input] = 1
      one = input
    when 3
      lookup[input] = 7
    when 4
      lookup[input] = 4
      four = input
    when 7
      lookup[input] = 8
    end
  end

  fives, sixes = unknown.partition {|i| i.length == 5}

  # decipher 5
  without_one = fives.map {|x| [x, x.tr(one,'')]}.to_h
  three,_ = without_one.partition {|orig,wo| wo.length == 3}
  three = three.first[0]
  without_one.delete(three)
  three = three.chars.sort.join
  lookup[three] = 3
  
  identify_five = four.tr(three,'')
  five,two = without_one.partition {|orig,wo| orig.include?(identify_five)}
  five = five.first[0].chars.sort.join
  two = two.first[0].chars.sort.join
  lookup[two] = 2
  lookup[five] = 5
  
  # decipher 6
  six,not_six = sixes.partition {|x| (x.split('') & one.split('')).length == 1}
  six = six.first
  sixes.delete(six)
  six = six.chars.sort.join
  lookup[six] = 6

  without_one_five = sixes.map {|x| [x, x.tr(one,'').tr(five, '')]}.to_h
  nine,zero = without_one_five.partition {|orig, wof| wof.empty? }
  nine = nine.first[0].chars.sort.join
  zero = zero.first[0].chars.sort.join
  lookup[nine] = 9
  lookup[zero] = 0

  lookup
end

def calculate(file_name)
  lines = File.readlines(file_name)

  y = lines.map do |line|
    input, output = line.chomp.split(" | ")

    inputs = input.split(" ")
    outputs = output.split(" ")

    lookup = decipher(inputs)
    # p lookup

    x = outputs.map do |o|
      sorted = o.chars.sort.join
      # puts "#{o} : #{sorted} : #{lookup[sorted]}"
      lookup[sorted]
    end
    p x.join.to_i
    x.join.to_i
  end
  p y.sum
end

calculate("example_input.txt")
calculate("input.txt")
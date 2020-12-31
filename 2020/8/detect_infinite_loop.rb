require 'Set'

class InfiniteLoop < StandardError
end

def detect_infinite_loop(operations)
  seen = Set.new
  pc = 0
  accumulator = 0
  until pc >= operations.length do
    raise InfiniteLoop.new "Operation #{pc} already executed. Accumulator: #{accumulator}" if seen.include?(pc)

    seen << pc
    m = /(?<op>acc|jmp|nop) (?<arg>[+-][0-9]+)/.match operations[pc]
    operation = m[:op]
    argument = m[:arg].to_i
    puts "[#{pc}] #{operations[pc].chomp} / acc: #{accumulator}"
    case operation
      when 'acc'
        accumulator += argument
        pc += 1
      when 'jmp'
        pc += argument
      when 'nop'
        pc += 1
    end
  end
  return accumulator
end

# Load all lines into list
operations = File.readlines("input.txt")
# puts "{Part 1: Accumulator immediately before infinite loop: #{detect_infinite_loop(operations)}"

# Part 2
# TODO: Would prefer to do this with filter_map but don't have Ruby 2.7
potential = operations.map.with_index { |operation,index| index if operation.match(/nop|jmp/) }.compact
potential.each do |op_index|
  temp_operations = operations.clone.map(&:clone)
  case temp_operations[op_index][0..2]
    when "nop"
      temp_operations[op_index].gsub!("nop", "jmp")
    when "jmp"
      temp_operations[op_index].gsub!("jmp", "nop")
  end

  begin
    puts "Accumulator at end: #{detect_infinite_loop(temp_operations)}"
    break
  rescue InfiniteLoop => e
    puts "[Infinite Loop] #{e.message}"
  end
  puts
end
require 'Set'

def detect_infinite_loop(operations)
  seen = Set.new
  pc = 0
  accumulator = 0
  until seen.include?(pc) do
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
puts "Accumulator immediately before infinite loop: #{detect_infinite_loop(operations)}"
require 'Set'

class RuleLookup
  def initialize(rules)
    @parents_of = Hash.new {|h,k| h[k] = []}

    rules.each do |rule|
      m = /(?<parent>[a-z ]+) bags contain(?<children>(?: [0-9]+ [a-z ]+ bags?(?:,|\.))+|(?: no other bags?\.))/.match rule
      if m[:children] != " no other bags."
        c = m[:children].scan /(?: [0-9]+ ([a-z ]+) bags?(?:,|\.))/
        c.each do |child|
          @parents_of[child.first] << m[:parent]
        end
      end
    end
  end

  def get_all_parents_of(target)
    parents = @parents_of[target]
    # p parents
    parents.reduce(Set.new(parents)) do |s,parent|
      s | get_all_parents_of(parent)
    end
  end
end

# Load all lines into list
rules = File.readlines("example.txt")

r = RuleLookup.new(rules)

target = "shiny gold"
p r.get_all_parents_of(target).size
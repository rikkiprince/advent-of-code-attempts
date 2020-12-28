require 'Set'

class RuleLookup
  def initialize(rules)
    @children_of = Hash.new {|h,k| h[k] = []}

    rules.each do |rule|
      m = /(?<parent>[a-z ]+) bags contain(?<children>(?: [0-9]+ [a-z ]+ bags?(?:,|\.))+|(?: no other bags?\.))/.match rule
      if m[:children] != " no other bags."
        c = m[:children].scan /(?: ([0-9]+) ([a-z ]+) bags?(?:,|\.))/
        c.each do |child|
          @children_of[m[:parent]] << ([child[1]] * child.first.to_i)
        end
      end
      @children_of[m[:parent]].flatten!
    end
  end

  def get_all_children_of(target)
    children = @children_of[target]
    grand_children = []
    grand_children << children
    children.each do |child|
      grand_children << get_all_children_of(child)
    end
    grand_children.flatten
  end
end

# Load all lines into list
rules = File.readlines("input.txt")

r = RuleLookup.new(rules)

target = "shiny gold"
p r.get_all_children_of(target).size
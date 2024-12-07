full_scale = true  

if full_scale
  rules_fname = 'rules.txt'
  manuals_fname = 'manuals.txt'
  # 4959
else 
  rules_fname = 'sample_rules.txt'
  manuals_fname = 'sample_manuals.txt'
  # 143
end 

def parse_rule_file(fname)
  rules = []
  File.readlines(fname).each_with_index do |line, index|
    first, second = line.strip.split('|',2)
    rules << [first.to_i, second.to_i]
  end
  rules 
end

rules = parse_rule_file(rules_fname)

puts "num rules: #{rules.length}"
# puts rules 



def get_manuals(fname)
  manuals = []

  File.foreach(fname) do |line|
    manuals << line.chomp.split(',').map(&:to_i)

  end
  manuals 
end

manuals = get_manuals(manuals_fname)

# debugging 
# new_manuals = manuals[3...4]
# manuals = new_manuals

puts "num manuals = #{manuals.length}"

manuals.each do |manual|
  puts manual
  puts "\n"
end

def is_before?(list, val1, val2)

  # puts "\n\ncheck"
  # puts "val1 = #{val1}"
  # puts "val2 = #{val2}"
  # puts list 

  idx1 = list.index(val1)
  idx2 = list.index(val2)

  # if either index is not present, the rule is
  # satisfied.
  return true if idx1.nil? || idx2.nil?

  return false if idx1 > idx2 
  true 
end 


# test
# puts "check is before"
# a = [1,2,3]
# puts a 
# # puts is_before?(a, 2, 3)
# # puts is_before?(a, 3, 1)
# # puts is_before?(a, 7, 1)
# puts is_before?(a, 2, 5)
# puts "----"


def manual_is_ordered_correct?(manual, rules)
  
  # puts "checking manual"
  # puts rules 

  ordered_correct = true 
  manual.each do |page|

    rules.each do |rule|

      if rule[0] == page
        # puts 'hit'
        # puts "rule: #{rule}"
        # puts "page: #{page}\n"
        ordered_correct = is_before?(manual, page, rule[1])
        if !ordered_correct
          return false
        end
      end 
    end   
  end 

  ordered_correct
end


# manual_a = [1,2,3]
# rules_a = []
# rules_a << [1,2]
# rules_a << [2,3]
# rules_a << [3,1]
# puts manual_is_ordered_correct?(manual_a, rules_a)
# puts "========="


correct_manuals = []
incorrect_manuals = []

manuals.each do |manual|
  if manual_is_ordered_correct?(manual, rules)
    correct_manuals << manual
  else
    incorrect_manuals << manual
  end
end 

# puts "num of correct manuals: #{correct_manuals.length}"

sum = 0

# --------------
# part 2 

def consolidate_rules(rules)
  all_rules = []
  
  found_rule= false
  lowest_idx = rules.length + 1

  before_map = {}

  rules.each do |rule|
    if before_map.key?(rule[0])
      before_map[rule[0]] << rule[1]
    else
      before_map[rule[0]] = []  # init
      before_map[rule[0]] << rule[1]
    end
  end

  before_map
end


before_map = consolidate_rules(rules)
# puts before_map
# puts "97 must be before: #{before_map[97]}"

reordered_manuals = []

def add_in_order(list, value, before_map)

  puts "add in order : #{list}: #{value}"

  if value.nil?
    puts "wont add nil value"
    return
  end

  if before_map.key?(value)
    puts " value must be before: #{before_map[value]}"

    if list.nil?
      list = []
      list << value
      return 
    end
    insert_idx = list.length + 1 

    after_vals = before_map[value]
    puts "after vals = #{after_vals}"

    after_vals.each do |item|
      idx = list.index(item)
      if idx.nil?
        puts "list does not have #{item}"
      else
        if idx.to_i < insert_idx.to_i
          insert_idx = idx 
        end 
      end 
    end

    puts "insert index = #{insert_idx}"
    list.insert(insert_idx, value)

  else 
    # not a key, no rule 
    puts "append at end"
    list << value 
  end 

  puts "results in -> #{list}"
end 

def reorder(manual, before_map) 

  new_manual = []
  
  first_time = true 
  manual.each do |item|
    if first_time
      new_manual << item
      first_time = false  
    else 
      add_in_order(new_manual, item, before_map) 
    end 
    puts new_manual
    puts "...."
  end 

  new_manual
end 

incorrect_manuals.each do |manual|
  manual = reorder(manual, before_map)
  reordered_manuals << manual.compact
end 


reordered_manuals.each do |manual|
  # assume odd length. 
  # puts manual.length
  puts 'reordered as : '
  puts manual
  puts "\n"
  
  if manual.nil? || manual.empty?
    puts 'nil or empty list'
  else
    mid_idx = manual.length / 2
  # puts mid_idx
    sum += manual[mid_idx].to_i
  end
end 

puts "sum = #{sum}"
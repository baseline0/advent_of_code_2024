rules_fname = 'sample_rules.txt'

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

manuals_fname = 'sample_manuals.txt'

def get_manuals(fname)
  manuals = []

  File.foreach(fname) do |line|
    manuals << line.chomp.split(',')

  end
  manuals 
end

manuals = get_manuals(manuals_fname)

new_manuals = manuals[0...1]
manuals = new_manuals

manuals.each do |manual|
  puts manual
  puts "\n"
end

def is_before?(list, val1, val2)
  idx1 = list.index(val1)
  idx2 = list.index(val2)

  return false if idx1.nil? || idx2.nil? || idx1 > idx2 
  true 
end 

def manual_is_ordered_correct?(manual, rules)
  
  # puts "checking manual"
  # puts rules 

  ordered_correct = true 
  manual.each do |page|

    rules.each do |rule|
      if rule[0] == page 
        ordered_correct = is_before?(manual, page, rule[1])
        if !ordered_correct
          return false
        end
      end 
    end   
  end 

  ordered_correct
end


correct_manuals = []

manuals.each do |manual|
  if manual_is_ordered_correct?(manual, rules)
    correct_manuals << manual
  end
end 

puts "num of correct manuals: #{correct_manuals.length}"

sum = 0

correct_manuals.each do |manual|
  # assume odd length. 
  # puts manual.length
  puts manual
  puts "\n"
  
  if manual.empty?
    puts 'empty list'
  else
    mid_idx = manual.length / 2
  # puts mid_idx
    sum += manual[mid_idx].to_i
  end
end 


puts "sum = #{sum}"
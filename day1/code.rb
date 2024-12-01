# irb
# load './code.rb'

col1 = []
col2 = []

# fname = 'sample_data.txt'
fname = 'data.txt'

File.foreach(fname) do |line|
  cols = line.chomp.split(' ')
  col1 << cols[0].to_i
  col2 << cols[1].to_i
end

puts 'data loaded'

sorted_col1 = col1.sort 
sorted_col2 = col2.sort 

# puts sorted_col1

difference = []
sum = 0

sorted_col1.each_with_index do |val, index|
  diff_val = (val - sorted_col2[index]).abs
  difference <<  diff_val
  sum += diff_val
end 

# puts 'difference calculated' # difference

puts sum  # 1222801 


# ----- part 2 
# how often each number from the left list appears in the right list.

similarity_score = 0

number_counts = {}

col1.each do |value|
  number_counts[value] ||=0
  number_counts[value] += 1
end 

puts number_counts


col2.each do |value|

  if col1.include?(value)
    similarity_score += (number_counts[value] * value)
  end 
end 


puts ' sim score = ' + similarity_score.to_s  # 22545250
# irb
# load './code.rb'

# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1

#  line = report
#  cols = levels

# fname = 'sample_data.txt'
fname = 'data.txt'

def is_safe?(arr)

  # safe = gradually increasing or gradually decreasing.
  min_diff = 1
  max_diff = 3

  (0...(arr.length() -1)).each do |i|
    
    return false if arr[i] == arr[i+1]

    diff = arr[i] - arr[i+1]
    return false if diff.abs > max_diff
    return false if diff.abs < min_diff

    if i == 0 
      if arr[i] < arr[i+1]
        is_increasing = true
        puts 'increasing'
      else 
        is_increasing = false
        puts 'decreasing'
      end 
    end 

    puts "i = #{i}"

    if i != 0 && is_increasing
        puts 'a'
        return false if arr[i+1] < arr[i]
    end 
      
    if i =! 0 && !is_increasing
        puts 'b'
        return false if arr[i] < arr[i + 1]
    end  

  end 
  true 
end 

count = 0

File.foreach(fname) do |line|
  report = line.chomp.split.map(&:to_i)
  p report 
  if is_safe?(report)
    count += 1
  end

  puts "count = #{count}"

end 

# 109 < x < 261
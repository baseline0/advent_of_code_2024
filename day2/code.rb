# irb
# load './code.rb'



#  line = report
#  cols = levels

# fname = 'sample_data.txt'
fname = 'data.txt'

def get_combos(arr)
  arr.each_with_index.map do |_, i|
    arr.dup.tap { |a| a.delete_at(i)}
  end
end

def is_safe?(arr)

  # safe = gradually increasing or gradually decreasing.
  min_diff = 1
  max_diff = 3

  is_increasing = false

  (0...(arr.length() -1)).each do |i|
    
    if arr[i] == arr[i+1]
      return false
    end

    diff = arr[i] - arr[i+1]
    if diff.abs > max_diff
      return false
    end
    if diff.abs < min_diff
      return false
    end

    if i == 0 
      if arr[i] < arr[i+1]
        is_increasing = true
        # puts 'increasing'
      else 
        is_increasing = false
        # puts 'decreasing'
      end 
    end 

    puts "i = #{i}: diff = #{diff}: is_increasing : #{is_increasing} : arr[i+1] < arr[i] #{arr[i+1] < arr[i]}"

    if i != 0
      if is_increasing 
        if arr[i+1] < arr[i]
        # puts 'a'
        return false
        end 
      end 
    end 
      
    if i != 0
      if !is_increasing 
        if arr[i] < arr[i + 1]
        # puts 'b'
        return false
        end
      end
    end  

  end 
  true 
end 

# -----------------
count = 0

File.foreach(fname) do |line|
  report = line.chomp.split.map(&:to_i)
  p report 

  if is_safe?(report)
    p 'safe'
    count += 1

  else 

    # try removing one item 

    any_combo_works = false 

    combos = get_combos(report)
    combos.each do |c|
      if is_safe?(c)
        any_combo_works = true 
      end 
    end

    if any_combo_works
      count += 1
    end

  end

  puts "count = #{count}"

end 

# part 1
# 109 < x < 261
# 218

# part 2: 290
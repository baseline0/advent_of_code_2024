# irb
# load './code.rb'

sample_data = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
# expected_parsed = '(2*4 + 5*5 + 11*8 + 8*5)' 

test_data = "This is the first section. don't()Skip this. do()Second section. don't()Skip again. do()Third section."

def parse_toggle(data)
  sections = []
  start_index = 0
  enabled = true 

  data.split(/\bdo\(\)\b|\bdon't\(\)\b/).each_with_index do |section, index|
    
    if enabled
      puts 'ENABLED'
      sections << section.strip
      enabled = false
    else
      puts 'DISABLED'
      start_index = data.index(/\bdo\(\)\b/, start_index) + 5
      enabled = true
    end

    puts index 
    puts section 
  end

  sections

end 

def process_string(string)
  result = ""
  state = :accepting
  count = 0

  string.chars.each_with_index do |char, index|

    # puts result 
    # puts index 

    # if char == "d"
    #   # puts 'char is d'
    #   puts string[index]
    #   end_index = [index + 4, string.length - 1].min
    #   puts string[index..end_index]
    #   # puts string[index..-1].start_with?("on't()")
    # end

    case state
    when :accepting
      result += char

      end_index = [index + 6, string.length - 1].min
      # puts string[index..end_index] 
      if string[index..end_index].start_with?("don't()")
        state = :rejecting
        count += 1
      end
    when :rejecting
      end_index = [index + 4, string.length].min
      if string[index..end_index].start_with?("do()")
        state = :accepting
      end
    end
  end

  # puts 'count'
  # puts count 

  result
end

# test_result = parse_toggle(test_data)
puts 'TEST RESULT'
# puts test_result.join(" ")
test_result = process_string(test_data)
puts test_result


def parse(data)
  data.scan(/mul\(([^()]*)\)/).flatten 
  # data.scan(/mul\(([1-9][0-9]*),([1-9][0-9]*)\)/).flatten
end 

# puts "expecting #{expected_parsed}"
# puts "got #{parse(sample_data)}"

def process(pairs)
  sum = 0
  pairs.map do |pair|
    values = pair.split(",")

    valid = true 
    values.each do |value|
      int_val = value.to_i
      if int_val.to_s == value && int_val > 0
        # puts '.'
      else
        valid = false
      end 
    end 
  
    if valid
      sum += values[0].to_i * values[1].to_i
    end 

  end
  sum 
end 


do_full_data = true 

if do_full_data
  fname = 'data.txt'
  data = File.read(fname)
  # data = sample_data


  data = process_string(data)
  # toggled_data = parse_toggle(data)
  # data = toggled_data.join(" ")
  pairs = parse(data)
  # puts pairs 

  result = process(pairs)
  puts result

end 



# 161 
# 655480 < x < 156391940 
#  156388521 ***

# part 2. 
# do() instruction enables future mul instructions.
# v don't()
# so toggle. 

# 72636043 < x < 156388521
# 75920122
full_scale = false

if full_scale
  fname = 'map.txt'
else
  fname = 'sample_map.txt'
end


# facing which way
UP = "^"
RIGHT = ">"
LEFT = "<"
DOWN  = "v"

# ========================== 

class Position

  attr_accessor :x, :y, :direction
  def initialize(x=0,y=0, direction=UP)
    @x = x
    @y = y 
    @direction = direction
  end


  def set(options = {})
    @x = options[:x] || @x 
    @y = options[:y] || @y 
    @direction = options[:direction] || @direction
  end 

end 


class GuardMap
  def initialize(rows, position)
    @rows = rows 
    @position = position

    # clear the symbol at start position
    clear_start_position(position.x, position.y, position.direction)
  end

  def clear_start_position(x,y, direction)
    if @rows[x][y] == direction
      @rows[x][y] = '.'
    else
      puts "#{x} #{y} is not #{direction}: @rows[x][y]"
    end 
  end  

  def is_obstacle?(x,y)
    # x -> row
    # y -> col

    return @rows[x][y] == '#'
  end 
 
  def step()
    """
    If there is something directly in front of you, 
      turn right 90 degrees.
    Otherwise, take a step forward.
    """ 

    puts 'step'

  end 
end

# ========================== 

rows = []
start_position = Position.new()

File.foreach(fname).with_index do |line, index|

  puts line 
  rows << line.chars
  direction = nil 

  if line.include?(UP)
    direction = UP 
    col_idx = line.index(UP)
  elsif line.include?(DOWN)   
    direction = DOWN 
    col_idx = line.index(DOWN)
  elsif line.include?(RIGHT)   
    direction = RIGHT 
    col_idx = line.index(RIGHT)
  elsif line.include?(LEFT)   
    direction = LEFT 
    col_idx = line.index(LEFT)
  end 

  if !direction.nil?
    start_position.x = index
    start_position.y = col_idx
    start_position.direction = direction 
  end 

end 

guard_map = GuardMap.new(rows, start_position)

# part 1
# How many distinct positions will the 
# guard visit before leaving the mapped area?

puts 'ans: '
full_scale = false

if full_scale
  fname = 'map.txt'
else
  fname = 'sample_map.txt'
end

# ========================== 

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

  def clone 
    Position.new(@x, @y, @direction)
  end 

  def ==(other)
    self.class == other.class &&
      @x == other.x &&
      @y == other.y &&
      @direction == other.direction 
  end 

  def set(options = {})
    @x = options[:x] || @x 
    @y = options[:y] || @y 
    @direction = options[:direction] || @direction
  end 

  def show
    puts "(x=#{@x}, y=#{@y}) with direction: #{@direction}"
  end 

end 


class GuardMap

  attr_accessor :rows, :position, :original_position

  def initialize(rows, position)
    @rows = rows 
    @position = position

    @num_rows = @rows.length
    @num_cols = @rows[0].length

    # clear the symbol at start position
    clear_start_position(position.x, position.y, position.direction)

    # part of stopping criteria
    @original_position = position

    # the info we want to count
    @visited = make_visited_map

  end

  def show
    show_map(visited=false)
  end 

  def show_visited
    show_map(visited=true)
  end 

  def make_visited_map
    visited = []

    for i in 0...@num_rows-1
      visited[i] = []

      for j in 0...@num_cols-1
        visited[i][j] = '.'
      end

    end

    visited 
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

    @rows[x][y] == '#'
  end 
 
  def set_visited(x,y)
    @visited[x][y] == 'X'
  end

  def count_visited
    sum = 0

    @visited.each do |row|
      row.each do |cell|
        if cell == 'X'
          sum += 1
        end 
      end 
    end 

    sum 
  end 

  def position_is_in_map?(x,y)
    if x < 0 || y < 0 || x >= @num_rows || y >= @num_cols
      return false 
    end
    true 
  end 

  def get_next_position(position)
    case position.direction
    when UP 
      x = position.x - 1
      y = position.y 
    when RIGHT
      x = position.x 
      y = position.y + 1
    when DOWN
      x = position.x + 1
      y = position.y 
    when LEFT
      x = position.x 
      y = position.y -1 
    end

    puts "next position is: #{x}, #{y}"
    return x,y
  end

  def turn_clockwise

    current_direction = @position.direction

    case current_direction
    when UP
      @position.direction = RIGHT
    when RIGHT
      @position.direction = DOWN
    when DOWN
      @position.direction = LEFT
    when LEFT
      @position.direction = UP
    else
      puts "bad direction: #{current_direction}"
    end 
  end 

  def step
    """
    If there is something directly in front of you, 
      turn right 90 degrees.
    Otherwise, take a step forward.
    """ 

    puts 'step'
    @position.show 

    exited_map = false
    end_position = @position.clone
 
    # travel as far as possible 
    # in this direction 
    x,y = get_next_position(end_position)
    while !is_obstacle?(x,y)
      end_position.set({x:x,y:y})
      set_visited(x,y)
      x,y = get_next_position(end_position)
      if !position_is_in_map?(x,y)
        return end_position, true
      end 
    end 
     
    return end_position, exited_map

    # puts "position is still in map: #{position_is_in_map?}"

  end 

  private

  def show_map(show_visited=false)

    if show_visited
      mymap = @visited
      puts 'visited map'
    else
      mymap = @rows
      puts 'guard map'
    end

    mymap.each do |row|
      puts row.join("")
    end 
  end

end

# ========================== 
# init 

def load_map_from_file(fname)

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
      puts "start position is: "
      puts start_position.show
    end 

  end
  
  return rows, start_position
end 


# ========================== 
# run 

rows, start_position = load_map_from_file(fname)

guard_map = GuardMap.new(rows, start_position)

# loop 
running = true 
while running 
  end_position, exited_map = guard_map.step 

  if exited_map
    puts 'exited map!'
    running = false 
  end
  if end_position == guard_map.original_position
    puts 'back at original start point'
    running = false
  end 
end 

# part 1
# How many distinct positions will the 
# guard visit before leaving the mapped area?


guard_map.show
guard_map.show_visited

puts 'ans: '
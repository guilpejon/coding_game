STDOUT.sync = true # DO NOT REMOVE

w, h = gets.split(" ").collect { |x| x.to_i }
n = gets.to_i
x, y = gets.split(" ").collect { |x| x.to_i }

Coordinate = Struct.new(:x, :y)
Building = Struct.new(:p1, :p2)
@map = Building.new(Coordinate.new(0, 0), Coordinate.new(w - 1, h - 1))
@batman = Struct.new(:x, :y).new(x,y)

def decide_next_jump
  # If width of the searchable area is 0, place batman on p1x
  if @map.p1.x == @map.p2.x
    @batman.x = @map.p1.x
  end

  # If height of the searchable area is 0, place batman on p1x
  if @map.p1.y == @map.p2.y
    @batman.y = @map.p1.y
  end

  # If its not on the right y position yet
  if @batman.y != @map.p1.y
    if @bomb_dir.include?('U')
      @batman.y -= 1 + (@map.p2.y - @map.p1.y) / 2
    elsif @bomb_dir.include?('D')
      @batman.y += 1 + (@map.p2.y - @map.p1.y) / 2
    end
  end

  # If its not on the right x position yet
  if @batman.x != @map.p1.x
    if @bomb_dir.include?('R')
      @batman.x += 1 + (@map.p2.x - @map.p1.x) / 2
    elsif @bomb_dir.include?('L')
      @batman.x -= 1 + (@map.p2.x - @map.p1.x) / 2
    end
  end
end

def update_searchable_map
  if @bomb_dir.include?('U')
    @map.p2.y = @batman.y - 1
  elsif @bomb_dir.include?('D')
    @map.p1.y = @batman.y + 1
  end

  if @bomb_dir.include?('R')
    @map.p1.x = @batman.x + 1
  elsif @bomb_dir.include?('L')
    @map.p2.x = @batman.x - 1
  end

  if @bomb_dir == 'U' || @bomb_dir == 'D'
    @map.p1.x = @map.p2.x = @batman.x
  elsif @bomb_dir == 'R' || @bomb_dir == 'L'
    @map.p1.y = @map.p2.y = @batman.y
  end
end

loop do
  @bomb_dir = gets.chomp
  update_searchable_map
  decide_next_jump
  puts "#{@batman.x} #{@batman.y}"
end

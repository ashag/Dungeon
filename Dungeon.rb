class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    # Possible solution: reassign players location
    # if @player.location == nil
    # @player.location = :largecave
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction(direction)
    room = find_room_in_dungeon(@player.location).connections[direction]
    if room == nil
      @player.location
    else
      room
    end
  end

  def go(direction)
    if find_room_in_dungeon(player.location).possible_directions.include? direction
      puts "You go " + direction.to_s
      @player.location = find_room_in_direction(direction)
      show_current_description
    else
      puts "You can't go #{direction}!!"
  end
end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def possible_directions
      @directions = []
      connections.each do |key, value|
        @directions << key
      end
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end
end



def driver
  # Create the main dungeon object
  my_dungeon = Dungeon.new("Fred Bloggs")

  # Add roms to the dungeon
  my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave })
  my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east => :largecave})

  # Start the dungeon by placing the player in the large cave
  my_dungeon.start(:largecave)

  while true
    puts "In which direction do you want to go now: "
    my_dungeon.go(gets.chomp)
  end
end

driver








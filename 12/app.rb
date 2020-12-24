require_relative 'input'
require 'byebug'

COMPASS_DEGREES = {
  0   => 'N',
  90  => 'E',
  180 => 'S',
  270 => 'W',
}

ship_info = {
  'N' => 0,
  'S' => 0,
  'E' => 0,
  'W' => 0,
  'heading' => 90
}

waypoint_info = {
  'N' => 1,
  'S' => 0,
  'E' => 10,
  'W' => 0,
  'heading' => 90
}

def move_ship(direction,value,ship_info)
  ship_dir = COMPASS_DEGREES[ship_info['heading']]
  case direction
  when 'F'
    ship_info[ship_dir] += value
  when 'R'
    ship_info['heading'] = fix_heading(ship_info['heading'] + value )
  when 'L'
    ship_info['heading'] = fix_heading(ship_info['heading'] - value )
  else
    ship_info[direction] += value
  end

  p ship_info
end

def move_ship_2(direction,value,ship_info,waypoint_info)
  waypoint_dir = COMPASS_DEGREES[waypoint_info['heading']]
  case direction
  when 'F'
    
    # ship_info[waypoint_info] += value * value
    # waypoint_info[waypoint_dir] += ship_info[waypoint_dir]
  else

  end
end

def fix_heading(degrees)
  # byebug if degrees == 360
  while degrees >= 360 || degrees < 0
    degrees = if degrees >= 360
                degrees - 360
              elsif degrees < 0
                360 + degrees
              end
  end
  degrees
end

def manhattan_position(ship_info)
  (ship_info['N'] - ship_info['S']).abs + (ship_info['E'] - ship_info['W']).abs
end

def find_position(info_hash)
  [info_hash['N'] -  info_hash['S'], info_hash['E'] - info_hash['W']]
end

count = 1
INPUT.each do |instruction|
  direction = instruction.scan(/\D/).first
  value = instruction.scan(/\d/).join('').to_i

  p instruction
  count += 1
  ship_info = move_ship(direction,value,ship_info)
  # ship_info['heading'] = fix_heading(ship_info['heading'])
end
p count


p manhattan_position(ship_info)
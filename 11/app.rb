require_relative 'input'
require 'byebug'

def copy_array(array)
  # Because everything is a pointer in ruby, we need new objects to avoid mutations
  array.map(&:dup)
end

def print_array(array)
  array.each do |line|
    p line
  end
end

def find_adjacent_seats(x,y,array)
  # Given a 2d array and an x,y position, find all of the surrounding items
  # Get the top 3, so x - 1, y -1 ; x-1, y ; x-1, y + 1
  # handle the top row corner cases
  top_row = if x == 0
              ['','','']
            else
              if y == 0
                ['',array[x-1][y],array[x-1][y+1]]
              elsif y == array[x-1].size - 1
                [array[x-1][y-1],array[x-1][y], '']
              else
                array[x-1][y-1..y+1]
              end
            end

  # Get the adjacent, so x, y-1 ; x, y ; x, y+1
  # just the edge cases to worry about
  middle_row =  if y == 0
                  ['', array[x][y..y+1]].flatten
                elsif y == array[x].size - 1
                  [array[x][y-1..y],''].flatten
                else
                  array[x][y-1..y+1]
                end

  # Get the bottom row, so: x + 1, y - 1; x+1, y; x+1, y+1
  # handle the bottom row corner cases
  bottom_row =  if x == array.size - 1
                  ['','','']
                else
                  if y == 0
                    ['',array[x+1][y],array[x+1][y+1]]
                  elsif y == array[x+1].size - 1
                    [array[x+1][y-1],array[x+1][y], '']
                  else
                    array[x+1][y-1..y+1]
                  end
                end

  [top_row,middle_row,bottom_row]
end

def change_seat_state(seats)
  case seats[1][1]
  when 'L'
    # check for occupied seats around you to determines state change
    if seats.flatten.join('').scan(/#/).size >= 1
      # if there any occupied seats, dont sit
      'L'
    else
      # else sit
      '#'
    end
  when '#'
    # if seated, check for four or more adjacent occupied seats (don't forget about yourself)
    if seats.flatten.join('').scan(/#/).size > 4
      # stand up
      'L'
    else
      # sit down
      '#'
    end
  when '.'
    '.'
  end
end

# mock up variables
count = 0
changed = true
current_state = copy_array(INPUT)
modified_input = copy_array(INPUT)

while changed
  changed = false
  count += 1

  # in each row
  current_state.each_with_index do |row,x|
    # go through each seat
    row.each_with_index do |_seat,y|
      # find the 3x3 array of seats
      surrounding  = find_adjacent_seats(x,y,current_state)

      # determine if we should change states
      new_state = change_seat_state(surrounding)
      if new_state != modified_input[x][y]
        # Compare the new state to the current state,
        modified_input[x][y] = new_state
        changed = true
      end
    end
  end

  # capture the current state of all seats
  # since changes all happen at once, commit them all at the end before the next iteration
  current_state = copy_array(modified_input)
end

p count
# find the total number of seats occupied once everyone settles down
p modified_input.flatten.join('').scan('#').size

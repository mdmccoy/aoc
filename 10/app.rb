# Combinatorics method?
# https://www.reddit.com/r/adventofcode/comments/karmhx/day_10_using_combinatorics_instead_of_graphs/

require_relative 'input'
require 'byebug'

# add 0, and max + 3 to input
INPUT << 0
INPUT << INPUT.max + 3
input = INPUT.sort!

# init hash
VOLT_JUMPS = {
  '1' => 0,
  '2' => 0,
  '3' => 0
}

GROUPS_OF_ONES = []


ARRAYS = []

def check_array(array)
  diffs = []
  array.each_with_index do |num, i|
    # next if we're at the end
    if i == array.size - 1
      next
    end

    # get the next item, figure out the voltage jump, collect the diffs for part 2
    jump_size = array[i+1] - num
    diffs << jump_size

    # increment the hash
    VOLT_JUMPS[jump_size.to_s] += 1
  end

  diffs
end
diffs = check_array(input)
p diffs
diff_array = diffs.join.split('3').select {|a| a != ''}

p diff_array
total = 1

diff_array.each do |diff_group|
  total *= case diff_group.size
  when 4
    7
  when 3
    4
  when 2
    2
  when 1
    1
  end
end

p total



# p VOLT_JUMPS




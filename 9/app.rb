require './input'

def check_for_sums(num, array, debug = false)
  # given a number, check to see if it is the sum of any two numbers in an array
  if debug
    puts "=========="
    puts "        num: #{num}"
    puts "      array: #{array}"
    puts "****"
  end

  # for each item in the array
  array.each_with_index do |check_num_1, i|
    puts "check_num_1: #{check_num_1}" if debug

    # go through all the other items
    new_array = array - [check_num_1]
    puts "  new_array: #{new_array}" if debug

    new_array.each do |check_num_2|
      if num == check_num_1 + check_num_2
        return true
      end
    end
  end
  false
end

def check_for_sequence(num, array, debug = false)
  # given number, search an array for a sequence that sums up to number
  check_sum = []
  puts "array: #{array}" if debug

  array.each do |addend|
    check_sum << addend
    p check_sum if debug

    if check_sum.sum == num
      # you found a sequence so return it
      puts "We found it: #{check_sum}" if debug
      return check_sum
    elsif check_sum.sum > num
      # we're past the sum, so we don't have a valid sequence starting with this number
      return false
    end
  end

  false
end

# Solution 1
answer = nil
INPUT.each_with_index do |num,i|
  next if i < PREAMBLE_LENGTH

  unless check_for_sums(num,INPUT[i-PREAMBLE_LENGTH..i-1])
    puts num
    answer = num
  end
end

# Solution 2
INPUT.each_with_index do |num, i|
  if (seq = check_for_sequence(answer, INPUT[i..]))
    p seq
    break
  end
end

p seq.min + seq.max



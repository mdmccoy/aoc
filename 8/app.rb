require 'byebug'
input = []
File.foreach('./input.txt', chomp: true) do |line|
  input << line
end

def replace_line(line)
  if line =~ /nop/
    line.gsub(/nop/, 'jmp')
  elsif line =~ /jmp/
    line.gsub(/jmp/, 'nop')
  else
    line
  end
end



input.each_with_index do |line, i|
  temp_input = input.dup
  temp_input[i] = replace_line(line)

  index = 0
  looping = true
  acc = 0
  known_lines = []

  #   byebug

  while looping
    if known_lines.include?(index) || index == input.size
      looping = false
      p acc
      raise 'found the end' if index == input.size
      next
    end
    known_lines << index

    instruction = temp_input[index].split(' ')
    p instruction

    case instruction[0]
    when 'nop'
      index += 1
    when 'acc'
      acc += instruction[1].to_i
      index += 1
    when 'jmp'
      index += instruction[1].to_i
    else
      raise 'else case'
    end
  end
end

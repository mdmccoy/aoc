require 'csv'

count = 0

CSV.foreach('/home/matt/source/aoc/2/aoc_inputs_day2.csv', headers: false) do |row|
  position_of_chars = row[0].split(' ')[0].split('-').map(&:to_i).map{|x| x -= 1 }
  number_of_chars = row[0].split(' ')[0].split('-')
  char = row[0].split(' ')[1]
  password = row[1].lstrip.split('')

  if password[position_of_chars[0]] == char || password[position_of_chars[1]] == char
    unless password[position_of_chars[0]] == char && password[position_of_chars[1]] == char
      count += 1
    end
  end

  # char_count = password.split('').count(char)

  # if char_count >= number_of_chars[0].to_i && char_count <= number_of_chars[1].to_i
  #   count += 1
  # end
end

p count

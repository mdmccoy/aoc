require 'fileutils'

puts "What day is it?"
day = gets.chomp

puts "Making directory..."
FileUtils.mkdir_p(day)

puts "Creating files..."
FileUtils.touch("#{day}/app.rb")
FileUtils.touch("#{day}/input.txt")
FileUtils.touch("#{day}/test.txt")
FileUtils.touch("#{day}/question.txt")

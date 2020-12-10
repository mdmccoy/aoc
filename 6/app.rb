require 'ostruct'
require 'byebug'

input = []

File.foreach('./input.txt', chomp: true) do |line|
    input << line
end

answers = []
input_buffer = []
count = 0

input.each_with_index do |line,i|
    # blank lines separate input blocks
    if line == '' || i == input.size - 1
        size_buffer = 0

        # last line
        if i == input.size - 1
            input_buffer << line.split('')
        end
        # byebug    

        # if youre the only person
        if input_buffer.size == 1
            size_buffer = input_buffer.flatten.size
        else
            # get the intersection of all items
            intersection = input_buffer.first
            begin
                input_buffer.each do |item|
                    intersection =  intersection & item
                end
            rescue => exception
                byebug
            end
            
            size_buffer = intersection.size
        end

        # input_buffer = input_buffer.join.split('').uniq.sort.join
        answers << OpenStruct.new(answers: input_buffer, size: size_buffer)
        input_buffer = []
    else
        # this line is the same passport, so collect it
        input_buffer << line.split('')
    end
end

p answers
p answers.sum(&:size)
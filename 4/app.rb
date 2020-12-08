require 'ostruct'
require 'byebug'

input = []

File.foreach('./input.txt', chomp: true) do |line|
    input << line
end

passports = []
input_buffer = []
count = 0


input.each_with_index do |line,i|
    # blank lines separate passports
    if line == '' || input.last == line
        # byebug if input.last == line
        input_string = ''
        passport = {}

        if input_buffer.empty?
            input_buffer << line
        end

        input_buffer.each do |items|
           items.split(' ')
           input_string = "#{items} #{input_string}"
        end
        input_string.strip!


        attributes_pairs = input_string.split(' ')
        attributes_pairs.each do |attribute|
            temp = attribute.split(':')
            passport[temp.first] = temp.last
        end

        passports << passport
        
        input_buffer = []
        count += 1
    else
        # this line is the same passport, so collect it
        input_buffer << line
    end
end

def validate_field(key,value)
    case key
    when 'byr'
        value = value.to_i
        value >= 1920 && value <= 2002
    when 'iyr'
        value = value.to_i
        value >= 2010 && value <= 2020
    when 'eyr'
        value = value.to_i
        value >= 2020 && value <= 2030
    when 'hgt'
        if value =~ /cm/
            value = value.slice(0,3)
            value = value.to_i
            value >= 150 && value <= 193
        else
            value = value.slice(0,2)
            value = value.to_i
            value >= 59 && value <= 76
        end
    when 'hcl'
        temp = value =~ /[#][0-9a-fA-F]{6,}/
        temp == 0
    when 'ecl'
        %w[amb blu brn gry grn hzl oth].include?(value)
    when 'pid'
        value.size == 9
    when 'cid'
        true
    end
end

valid = 0
passports.each do |passport|
    if passport.size == 8
        valid_attributes = passport.map do |key,value|
            validate_field(key,value)
        end
        if valid_attributes.all?
            valid += 1
        end
    elsif passport.size == 7 && passport['cid'].nil?
        valid_attributes = passport.map do |key,value|
            validate_field(key,value)
        end
        if valid_attributes.all?
            valid += 1
        end        
    end
end

p passports.last
p passports.size
p valid


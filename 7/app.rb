require 'byebug'

input = []

File.foreach('./test2.txt', chomp: true) do |line|
  input << line
end

@bags = {}

def make_bags(input)
  input.map do |bag_string|
    contents = []
    # light orange bags contain 1 dark maroon bag, 3 dim maroon bags, 5 striped green bags, 2 pale aqua bags.
    bag_string = bag_string.split('contain')
    # ["light orange bags ", " 1 dark maroon bag, 3 dim maroon bags, 5 striped green bags, 2 pale aqua bags."]

    type = bag_string.first.split(/bag/).first.strip
    # 'light orange'


    bag_string.last.scan( /(\d[ A-Za-z]+)/).each do |bag|
      # 1 dark maroon bag
      size = bag.first.split(' ').first.strip.to_i # 1
      contents_type = bag.first.split(' ')[1..-2].join(' ').strip # 'dark maroon'      
      contents << [contents_type, size]
    end

    @bags[type] = contents
  end
end

# count = 0
# for each bag:
#   if contains-shiny(bag) is true: count++

# function contains-shiny(bag):
#   for each sub-bag of bag:
#     if sub-bag = "shiny gold" or contains-shiny(sub-bag): return true
#   return false

make_bags(input)

def contains_shiny(bag)
  return false unless bag

  bag.each do |sub_bag|
    sub_bag = sub_bag[0]
    if sub_bag =~ /shiny gold/ || contains_shiny(@bags[sub_bag])
      return true
    end
  end

  false
end

count = 0
@bags.each do |bag, sub_bags|
  count += 1 if contains_shiny(sub_bags)
end
p count


def count_bags(bag)
  # p bag
  @total += bag.map(&:last).sum
  bag.each do |sub_bag|
    # p sub_bag
    contents = @bags[sub_bag[0]]
    next if contents.empty?

    sub_bag[1].times do
      count_bags(contents)
    end
  end
end

@total = 0
count_bags(@bags['shiny gold'])
p @total
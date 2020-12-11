input = []

File.foreach('./input.txt', chomp: true) do |line|
  input << line
end

def make_bags(input)
  input.map do |bag_string|
    contents = {}
    # light orange bags contain 1 dark maroon bag, 3 dim maroon bags, 5 striped green bags, 2 pale aqua bags.
    p bag_string = bag_string.split('contain')
    # ["light orange bags ", " 1 dark maroon bag, 3 dim maroon bags, 5 striped green bags, 2 pale aqua bags."]

    p type = bag_string.first.split(/bag/).first.strip
    # 'light orange'

    bag_string.last.scan( /(\d[ A-Za-z]+)/).each do |bag|
      # 1 dark maroon bag
      p size = bag.first.split(' ').first.strip.to_i # 1
      p contents_type = bag.first.split(' ')[1..-2].join(' ').strip # 'dark maroon'
      contents[contents_type] = size
    end

    p Bag.new(type, contents)
  end
end

class Bag
  attr_accessor :type, :contents

  def initialize(type, contents)
    @type = type
    @contents = contents || {}
  end
end



p make_bags(input).size
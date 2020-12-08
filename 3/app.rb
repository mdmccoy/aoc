require 'byebug'

tree_counts,route = [],[]

File.foreach('./input.txt', chomp: true) do |line|
    route << line.split('')
end

[[1,1],[3,1],[5,1],[7,1],[1,2]].each do |moves|
    column,tree_count = 0,0

    route.each_with_index do |line,i|
        # skip a row
        if moves.last == 2                    
            next unless i % 2 == 0
        end

        # check for tree
        if line[column] == '#'
            tree_count += 1 
        end
    
        # move
        column += moves.first
    
        # reset at the end of a row
        if column >= 31
            column -= 31
        end
    end
    
    tree_counts << tree_count
end

p tree_counts

total = 1
tree_counts.each do |item|
    total *= item
end

p total
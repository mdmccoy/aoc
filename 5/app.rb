require 'byebug'
require 'ostruct'

input = []
File.foreach('./input.txt', chomp: true) do |line|
  input << line
end

class BinarySpaceTree
  attr_accessor :tickets,:seat, :seat_id, :seat_ids, :all_possible_seat_ids
  ROWS = *0..127
  COLUMNS = *0..7

  def initialize(tickets)
    @tickets = tickets
    @seat_ids = []
    @all_possible_seat_ids = []
    get_seat_ids
    get_all_possible_seat_ids
  end

  def print
    puts tickets
  end

  def find_seat(num)
    # feed in string row or integer row number
    ticket = num.is_a?(String) ? num : tickets[num]
    row = ROWS
    column = COLUMNS


    ticket.each_char do |move|
      if move == 'F'
        row = row[0, row.size / 2]
      elsif move == 'B'
        row = row[row.size / 2, row.size - 1]
      elsif move == 'R'
        column = column[column.size / 2, column.size - 1]
      elsif move == 'L'
        column = column[0, column.size / 2]
      end
    end

    @seat_id = get_seat_id(row[0],column[0])
    @seat = OpenStruct.new(row: row[0], column: column[0], seat_id: seat_id)
  end

  def get_seat_id(row,column)
    row * 8 + column
  end

  def get_seat_ids
    ROWS.each do |i|
      seat_ids << find_seat(i).seat_id
    end
  end

  def highest_seat_id
    seat_ids.sort.last
  end

  def get_all_possible_seat_ids
    ROWS.each do |i|
      COLUMNS.each do |j|
        all_possible_seat_ids << get_seat_id(i,j)
      end
    end
  end
end

bst = BinarySpaceTree.new(input)
p bst.highest_seat_id
p bst.all_possible_seat_ids.size
p bst.seat_ids.sort.size


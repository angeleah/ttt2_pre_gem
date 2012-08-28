class Board
  
  def initialize
    @cells = Array.new(9) {" "}
  end
  
  def hi
    puts "hi"
  end
  
  def get(cell_number)
    @cells[cell_number]
  end
  
  def set(cell_number, mark) 
    @cells[cell_number] = mark
  end
  
  def undo_move(cell_number)
    @cells[cell_number] = " "
  end
  
  def available_spaces
    available_spaces = @cells.each_with_index.select { |i, idx| i =~ / / }
    available_spaces = available_spaces.map{|i| i[1] }
    available_spaces
  end
  
  def cell_occupied?(cell_number)
     get(cell_number.to_i - 1) != " "
  end
  
  def current_state
    current_state = @cells.map {|c| c}
  end
  
  def clear_all_spaces
    mark = " "
    @cells.each_with_index do |cell, index|
      set(index, mark)
    end
  end
    
  def rows
     [ @cells[0..2],
     @cells[3..5],
     @cells[6..8] ]
  end
  
  def columns
    rows.transpose
  end
  
  def diagonal_forward
    [ @cells[2],
    @cells[4],
    @cells[6] ]
  end
  
  def diagonal_back
    [ @cells[0],
    @cells[4],
    @cells[8] ]
  end
  
  def possible_winning_combinations
    possible_winning_combinations = []
    rows.collect{|row| possible_winning_combinations << row }
    columns.collect{|column| possible_winning_combinations << column }
    possible_winning_combinations << diagonal_forward
    possible_winning_combinations << diagonal_back
  end
end 
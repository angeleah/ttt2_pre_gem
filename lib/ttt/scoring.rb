require "ttt/board"

class Scoring
  
  def winner?(board)
     winner = false
     board.possible_winning_combinations.each do |combo|
       if combo.uniq.length == 1 && combo[0] != " "
          winner = true
       end
     end
     winner
  end
  
  def winning_mark(board)
    board.possible_winning_combinations.each do |combo|
      if combo.uniq.length == 1 && combo[0] != " "
         return combo[0]
      end
    end
  end
  
  def draw?(board)
    winner?(board) == false && board.available_spaces.count == 0
  end
end  
require "ttt/board"
require "ttt/scoring"
require "ttt/validate"
require "ttt/human_player"
require "ttt/computer_player"

class Game
  
  attr_reader :players, :board
  
  def initialize
    @board = Board.new
    @scoring = Scoring.new
    @validate = Validate.new
    @players = []
  end
  
  def create_computer_player(mark)
    @players << ComputerPlayer.new(mark)
  end
    
   def create_human_player(mark)
     @players << HumanPlayer.new(mark)
   end
   
   def get_player_move(player)
     index = player - 1
     @players[index].get_move(@board)
   end
   
   def move_valid?(move)
     (0..8).include?(move)
   end
   
   def make_move_player(player, move)
     index = player - 1
     mark = @players[index].mark
     return false unless move_valid?(move)
     @board.set(move, mark)
     prepare_display_state
   end
   
   def square_taken?(cell_number)
      @board.cell_occupied?(cell_number)
   end
   
   def prepare_display_state
     board_display_state = []
     current_state = @board.current_state
     cell_numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
     index = 0
     current_state.each do |cell|
       board_display_state << cell_numbers[index] if cell == " "
       board_display_state << current_state[index] unless cell == " "
       index += 1
     end
     board_display_state
   end
   
   def is_over?
    @scoring.winner?(@board) || @scoring.draw?(@board)
   end
  
   def result
     message_key = :draw
     @players.each_with_index do |player, i|
       num = i + 1
       if @scoring.winning_mark(@board) == player.mark
         message_key = "player_#{num}_win".to_sym
       end
     end
     message_key
   end
end
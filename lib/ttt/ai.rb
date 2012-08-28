require "ttt/scoring"
require "ttt/board"

class Ai
  
  def initialize(player, board)
    @board = board
    @scoring = Scoring.new
    @max_mark = player.mark
  end
  
  def find_opponent_mark
    state = @board.current_state
    min_mark = state.reject {|c| c =~ /^#{@max_mark}|\s{1}$/ }
    @min_mark = min_mark[0]
  end
  
  def select_optimal_start_move
    start_moves = [0, 2, 4, 6, 8]
    best_move = start_moves.sample
  end
  
  def random_move
    move =  @board.available_spaces.sample
  end
    
  def find_best_move
    if @board.available_spaces.count == 9
      best_move = select_optimal_start_move
    else
      find_opponent_mark
      move_reference, best_score = max_move
      best_move = move_reference
    end
    best_move
  end
      
  def max_move
    best_move = nil
    best_score = nil
    @board.available_spaces.each do |move|
      @board.set(move, @max_mark)
      if state_is_terminal?
        score = evaluate_the_board
      else
        move_reference, score = min_move
      end
      @board.undo_move(move)
      if best_score.nil? || score > best_score
        best_score = score
        best_move = move
      end
    end
    return best_move, best_score
  end
  
  def min_move
    best_move = nil
    best_score = nil
    @board.available_spaces.each do |move|
      @board.set(move, @min_mark)
        if state_is_terminal?
          score = evaluate_the_board
        else
          move_reference, score = max_move
        end
      @board.undo_move(move)
      if best_score.nil? || score < best_score
        best_score = score
        best_move = move
      end
    end
    return best_move, best_score
  end
  
  def state_is_terminal?
    @scoring.winner?(@board) || @scoring.draw?(@board)
  end
  
  def evaluate_the_board
    decision = nil
    decision = 1 if @scoring.winner?(@board) && @scoring.winning_mark(@board) == @max_mark
    decision = -1 if @scoring.winner?(@board) && @scoring.winning_mark(@board) != @max_mark
    decision = 0 if @scoring.draw?(@board)
    decision
  end
end
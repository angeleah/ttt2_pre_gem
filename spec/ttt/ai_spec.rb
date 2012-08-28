require "spec_helper"
require "ttt/board"
require "ttt/computer_player"
require "ttt/ai"

describe "@ai" do

  before(:each) do
    @board = Board.new
    @max = ComputerPlayer.new(@mockui)
    @max.set_mark("X")
    @ai = Ai.new(@max, @board)
  end

  it "should be able to return a random move" do
      @board.set(0,"X")
      @board.set(1,"O")
      @board.set(2,"X")
      @board.set(3,"X")
      @board.set(4,"O")
      @board.set(5,"X")
      @board.set(6,"O")
      @board.set(7," ")
      @board.set(8," ")
      @ai.random_move.should satisfy {|s| [7,8].include?(s)}
  end
  
  it 'should detect the opponent mark if there is one' do
    @board.set(0,"X")
    @board.set(1,"O")
    @board.set(2,"X")
    @board.set(3,"X")
    @board.set(4,"O")
    @board.set(5," ")
    @board.set(6," ")
    @board.set(7," ")
    @board.set(8," ")
    @ai.find_opponent_mark
    @ai.find_opponent_mark.should == "O"
  end
  
  it "should select a pre selected move on a board of all blank spaces" do
    @board.stub(:available_spaces).and_return([" ", " ", " ", " ", " ", " ", " ", " ", " ",])
    @ai.select_optimal_start_move.should satisfy {|s| [0,2,4,6,8].include?(s)}
  end
    
  it "should be able to determine if the state is terminal in a winner situation" do
    @board.stub(:possible_winning_combinations).and_return([["X", "X", "X"],[ "O", " ", " "],["O", " ", " "],["X", "O", "O"],[ "X", " ", " "],["X", " ", " "],[ "X", " ", "O"],["X", " ", " "]])
    @ai.state_is_terminal? == true
  end
  
  it "should be able to determine if the state is terminal in a draw situation" do
    @board.stub(:possible_winning_combinations).and_return([["X", "O", "X"],[ "O", "X", "X"],["O", "X", "O"],["X", "O", "O"],[ "O", "X", "X"],["X", "X", "O"],[ "X", "X", "O"],["X", "X", "O"]])
    @board.stub(:available_spaces).and_return([])
    @ai.state_is_terminal? == true
  end

  it 'should be able to evaluate the board negatively for an @ai loss' do
    @board.stub(:possible_winning_combinations).and_return([["O", " ", "X"],[ "X", "X", " "],["O", "O", "O"],["O", "X", "O"],[ " ", "X", "O"],["X", " ", "O"],[ "X", "X", "O"],["O", "X", "O"]])
    @ai.evaluate_the_board.should == -1
  end
  
  it 'should be able to evaluate the board positively for an @ai win' do
    @max.stub(:mark).and_return("X")
    @board.stub(:possible_winning_combinations).and_return([["X", " ", "O"],[ "O", "O", " "],["X", "X", "X"],["X", "O", "X"],[ " ", "O", "X"],["O", " ", "X"],[ "O", "O", "X"],["X", "O", "X"]])
    @ai.evaluate_the_board.should == 1
  end
  
  it "should be able to evaluate the board neutrally in a draw situation" do
    @max.stub(:mark).and_return("X")
    @board.stub(:available_spaces).and_return([])
    @ai.evaluate_the_board.should == 0
  end
  
  it "should be able to find the best move for max with one terminal state move available" do
    @board.set(0,"X")
    @board.set(1,"O")
    @board.set(2,"X")
    @board.set(3,"O")
    @board.set(4,"O")
    @board.set(5," ")
    @board.set(6,"O")
    @board.set(7,"X")
    @board.set(8,"X")
    @ai.find_best_move.should == 5
  end
  
   it "should be able to find the best move with one terminal state move available and one loss" do
     @board.set(0,"O")
     @board.set(1,"X")
     @board.set(2,"O")
     @board.set(3,"X")
     @board.set(4,"O")
     @board.set(5,"O")
     @board.set(6,"X")
     @board.set(7," ")
     @board.set(8," ")
     @ai.find_best_move.should == 8
   end
   
   it "should be able to select square 7 as the best square for this board" do
     @board.set(0,"X")
     @board.set(1,"O")
     @board.set(2," ")
     @board.set(3,"O")
     @board.set(4,"O")
     @board.set(5,"X")
     @board.set(6,"X")
     @board.set(7," ")
     @board.set(8," ")
     @ai.find_best_move.should == 7
   end
   
   it "should be able to select square 1 as the best square for this board" do
     @board.set(0," ")
     @board.set(1," ")
     @board.set(2," ")
     @board.set(3," ")
     @board.set(4,"O")
     @board.set(5," ")
     @board.set(6,"X")
     @board.set(7,"O")
     @board.set(8,"X")
     @ai.find_best_move.should == 1
   end
   
   it "should be able to select square 4 as the best square for this board" do
     @board.set(0,"X")
     @board.set(1," ")
     @board.set(2," ")
     @board.set(3,"O")
     @board.set(4," ")
     @board.set(5,"O")
     @board.set(6," ")
     @board.set(7," ")
     @board.set(8," ")
     @ai.find_best_move.should == 4
   end
   
   it "should be able to select square 3 as the best square for this board" do
     @board.set(0,"X")
     @board.set(1," ")
     @board.set(2,"O")
     @board.set(3," ")
     @board.set(4," ")
     @board.set(5," ")
     @board.set(6," ")
     @board.set(7," ")
     @board.set(8," ")
     @ai.find_best_move.should == 3
   end
end
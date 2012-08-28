require "spec_helper"
require "ttt/board"
require "console/mock_ui"
require "ttt/game"
require "ttt/player"
require "ttt/human_player"
require "ttt/computer_player"
require "ttt/scoring"

describe "Game" do
  
  let (:board)   { Board.new }
  let (:mockui)  { MockUi.new }
  let (:game)    { Game.new }
  let (:scoring) { Scoring.new }
  
  it "should be able to create a human player" do
    game.create_human_player("W")
    game.players[0].should be_an_instance_of(HumanPlayer)
    game.players[0].mark.should == "W"
  end
  
  it "should be able to create a computer player" do
    game.create_computer_player("X")
    game.players[0].should be_an_instance_of(ComputerPlayer)
    game.players[0].mark.should == "X"
  end
  
  it "should be able to prepare a board for display" do
    game.board.set(0,"X")
    game.board.set(1,"O")
    game.board.set(2,"X")
    game.board.set(3,"O")
    game.prepare_display_state.should == ["X","O","X","O","5","6","7","8","9"]
  end
  
  it "return true on a valid move" do
    move = 7
    game.move_valid?(move).should == true
  end
  
  it "should be able to determine if the game is over in a winner situation" do
    game.board.stub(:possible_winning_combinations).and_return([["X", "X", "X"],[ "O", " ", " "],["O", " ", " "],["X", "O", "O"],[ "X", " ", " "],["X", " ", " "],[ "X", " ", "O"],["X", " ", " "]])
    game.is_over?.should == true
  end
  
  it "should be able to determine if the game is over in a draw situation" do
    game.board.stub(:possible_winning_combinations).and_return([["X", "O", "X"],[ "O", "X", "X"],["O", "X", "O"],["X", "O", "O"],[ "O", "X", "X"],["X", "X", "O"],[ "X", "X", "O"],["X", "X", "O"]])
    game.board.stub(:available_spaces).and_return([])
    game.is_over?.should == true
  end
  
  it "should return the message key as the result" do
     scoring.stub(:winning_mark).and_return(false)
     game.result.should == :draw
  end
end
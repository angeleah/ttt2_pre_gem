require "spec_helper"
require "ttt/board"

describe "Board" do
  
  let(:board) { Board.new } 
 
  it 'should initialize with blank spaces' do
    (1..8).each do |cell|
      board.get(cell).should == " "
    end
  end

  it 'can write and read a mark on a space' do
    board.set(2, "X")
    board.get(2).should == "X"
    board.set( 6, "O")
    board.get(6).should == "O"
  end
  
  it "should be able to undo a move" do
    board.set(0,"X")
    board.current_state.should ==  ["X"," "," "," "," "," "," "," "," "]
    board.undo_move(0)
    board.current_state.should ==  [" "," "," "," "," "," "," "," "," "]
  end
  
  it "should be able to clear all the spaces" do
    board.set(0,"X")
    board.set(1,"O")
    board.set(2,"X")
    board.set(3,"X")
    board.set(4,"O")
    board.set(5,"X")
    board.set(6,"O")
    board.current_state.should ==  ["X","O","X","X","O","X","O"," "," "]
    board.clear_all_spaces
    board.current_state.should ==  [" "," "," "," "," "," "," "," "," "]
  end
  
  it 'should be able to gather the unmarked spaces' do
    board.set(0,"X")
    board.set(1,"O")
    board.set(2,"X")
    board.set(3,"X")
    board.set(4,"O")
    board.set(5,"X")
    board.set(6,"O")
    board.available_spaces.should == [7,8]
  end
  
  it "can gather the current_state" do
    board.set(0,"X")
    board.set(1,"O")
    board.set(2,"X")
    board.set(3,"O")
    board.current_state.should == ["X","O","X","O"," "," "," "," "," "]
  end
  
  it "should be able to tell if a square is occupied" do
    board.set(0,"X")
    board.set(1,"O")
    board.set(2,"X")
    board.set(3,"O")
    board.cell_occupied?(2).should == true
  end
  
  describe "board divisions" do
  
    before(:each) do
      board.set(1, "X")
      board.set(6, "O")
      board.set(8, "X")
    end
    
    it "should be able to divide the board up into rows" do
      board.rows.count.should == 3
      board.rows.should == [[" ", "X", " "],
                            [" ", " ", " "],
                            ["O", " ", "X"]]
    end

    it "should be able to divide the board up into columns" do
      board.columns.should == [[" ", " ", "O"],
                               [ "X", " ", " "],
                               [" ", " ", "X"]]
    end
    
    it "should be able to find a diagonal forward" do
      board.diagonal_forward.should == [ " ", " ", "O"]
    end
    
    it "should be able to find a diagonal back" do
      board.diagonal_back.should == [" ", " ", "X"]
    end
    
    it "should be able to return all of the possible winning combinations" do
      board.possible_winning_combinations.should == [[" ", "X", " "],[ " ", " ", " "],["O", " ", "X"],[" ", " ", "O"],[ "X", " ", " "],[" ", " ", "X"],[ " ", " ", "O"],[" ", " ", "X"]]
    end
  end
end

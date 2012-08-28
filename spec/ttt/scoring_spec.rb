require "spec_helper"
require "ttt/board"
require "ttt/scoring"

describe "Scoring" do

  let (:board)  { Board.new }
  let(:scoring) { Scoring.new }

  it 'should not determine a winner with a board of all spaces' do
    board.set(0, " ")
    board.set(4, " ")
    board.set(8, " ")
    scoring.winner?(board).should == false
  end

  it 'should not determine a winner with a winner of mixed symbols' do
    board.set(0, "X")
    board.set(4, "O")
    board.set(8, " ")
    scoring.winner?(board).should == false
  end

  it "should be able to determine a winning board when passed a diagonal win" do
    board.set(0, "X")
    board.set(4, "X")
    board.set(8, "X")
    scoring.winner?(board).should == true
  end

  it "should be able to determine a column win" do
    board.set(0, "O")
    board.set(3, "O")
    board.set(6, "O")
    scoring.winner?(board).should == true
  end

  it "should be able to determine a row win" do
     board.set(0, "O")
     board.set(1, "O")
     board.set(2, "O")
     scoring.winner?(board).should == true
  end

  it "should be able to determine if 'O' was the winner" do
    board.set(0, "O")
    board.set(1, "O")
    board.set(2, "O")
    scoring.winning_mark(board).should == "O"
  end

  it "should be able to determine if 'X' was the winner" do
    board.set(0, "X")
    board.set(4, "X")
    board.set(8, "X")
    scoring.winning_mark(board).should == "X"
  end

  it "should be able to determine if the game was a draw" do
     board.set(0,"X")
     board.set(1,"O")
     board.set(2,"X")
     board.set(3,"X")
     board.set(4,"O")
     board.set(5,"X")
     board.set(6,"O")
     board.set(7,"X")
     board.set(8,"O")
     scoring.draw?(board).should == true
  end
end

require "spec_helper"
require "ttt/board"
require "console/ui"
require "ttt/game"
 
describe "Ui" do

  let (:board) { Board.new }

  before(:each) do
    @test_out = StringIO.new
    @test_in = StringIO.new
    @ui = Ui.new(@test_out, @test_in)
    @game = Game.new
  end
  
  it "should be able to receive input" do
    @test_in.stub(:gets).and_return("Y")
    @ui.read_input.should == "Y"
  end

  it "should display a board with no player values" do
    @game.stub(:prepare_display_state).and_return(state =["1","2","3","4","5","6","7","8","9"])
    @ui.display_board(state)
    @test_out.string.should == "\n 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 \n\n"
  end

  it "should display a board with values on it" do
    @game.stub(:prepare_display_state).and_return(state =["X","O","3","X","5","X","7","O","9"])
    @ui.display_board(state)
    @test_out.string.should == "\n X | O | 3 \n---+---+---\n X | 5 | X \n---+---+---\n 7 | O | 9 \n\n"
  end
end
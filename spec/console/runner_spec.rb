require "spec_helper"
require "console/runner"
require "console/mock_ui"
require "ttt/game"
require "ttt/validate"

describe "runner" do
  
  before(:each) do
    @mockui = MockUi.new
    @runner = Runner.new(@mockui)
    @validate = Validate.new
  end
  
  it "should get the player type" do
    @mockui.input = "h"
    @runner.get_player_type.should == "H"
  end
  
  it "should get the player mark" do
    @mockui.input = "w"
    @runner.get_player_mark.should == "W"
  end
  
  it "should be able to get a human move" do
    @mockui.input = "3"
    @runner.create_game
    @runner.get_human_move.should == 2
  end

  it 'should let the player choose to play again' do
    @mockui.input = "Y"
    @runner.play_again?.should == true
  end
end
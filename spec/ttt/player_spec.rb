require "spec_helper"
require "ttt/player"

describe "Player" do

  let(:player) { Player.new }
  
  it "should be able to set a mark" do
    mark = 'T'
    player.set_mark(mark).should == "T"
  end
  
  it "should be able to read a mark" do
    player.set_mark("S")
    player.mark.should == "S"
  end
end
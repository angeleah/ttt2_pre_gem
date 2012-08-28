require "spec_helper"
require "console/mock_ui"
require "ttt/board"
require "ttt/game"
require "ttt/human_player"

describe "human_player" do
  
  let (:mockui) { MockUi.new}
  let (:board)  { Board.new }
  let (:game)   { Game.new(mockui) }
  let (:player) { HumanPlayer.new("O") }
  
  it "get_move should return false" do
    player.get_move(board).should == false
  end
end
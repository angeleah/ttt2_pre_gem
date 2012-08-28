require "spec_helper"
require "console/mock_ui"
require "ttt/game"
require "ttt/board"
require "ttt/computer_player"
require "ttt/ai"

describe "computer_player" do

  let (:mockui) { Mockui.new }
  let (:game)   { Game.new(mockui) }
  let (:board)  { Board.new }
  let (:player) { ComputerPlayer.new("O") }
  let (:ai)     { Ai.new(player, board) }
   
  it "should be able to get a move" do
    player.get_move(board).should satisfy {|s| [0,1,2,3,4,5,6,7,8].include?(s)}
  end
end
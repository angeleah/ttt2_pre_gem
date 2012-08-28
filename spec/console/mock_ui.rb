require "spec_helper"
require "ttt/message"
require "ttt/board"

class MockUi
  
  attr_writer :input
  attr_reader :last_displayed_message
  
  def display_message(*keys)
    @last_displayed_message = keys.last
  end
  
  def read_input
    @input
  end
  
  def display_board(board)
    state = board.current_state
    @output = " #{state[0]} | #{state[1]} | #{state[2]} \n---+---+---\n #{state[3]} | #{state[4]} | #{state[5]} \n---+---+---\n #{state[6]} | #{state[7]} | #{state[8]} \n"
  end
end
require "ttt/message"

class Ui
  
  def initialize(output = $stdout, input = $stdin)
    @message = Message.new
    @output = output
    @input = input
  end
  
  def display_message(*keys)
    @output.print(@message.passed(*keys))
  end
  
  def read_input
     @input.gets.chomp
  end
  
  def display_board(state)
   state = state
   @output.print "\n" " #{state[0]} | #{state[1]} | #{state[2]} \n---+---+---\n #{state[3]} | #{state[4]} | #{state[5]} \n---+---+---\n #{state[6]} | #{state[7]} | #{state[8]} \n" "\n"
  end
end
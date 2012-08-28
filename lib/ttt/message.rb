class Message
  
  def initialize
    
    @message = {
       welcome: "Welcome to Tic Tac Toe! You will create 2 players. The first player you create will go first.\n",
       create_player: "Create a player.\n",
       determine_player_type: "Do you want the player to be human or computer? (H/C)\n",
       select_player_mark: "Please select a single letter to represent the player.\n",
       invalid_selection: "That is an invalid selection, please make a valid selection.\n",
       select_square: "Please select an open square.\n",
       player_1_win: "Player 1 is the winner!\n",
       player_2_win: "Player 2 is the winner!\n",
       draw: "It's a draw.\n",
       play_again?: "Would you like to play again? (Y/N)\n",
    }
  end
  
  def passed(*keys)
    message = String.new
    keys.each do |key|
      message << @message[key]
    end
    message
  end
end
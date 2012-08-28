require "ttt/game"
require "ttt/validate"

class Runner
  
  def initialize(ui)
    @ui = ui
    @validate = Validate.new
  end
  
  def start_the_game
    create_game
    @ui.display_message(:welcome, :create_player, :determine_player_type)
    type_1 = get_player_type
    @ui.display_message(:select_player_mark)
    mark_1 = get_player_mark
    @ui.display_message(:determine_player_type)
    type_2 = get_player_type
    @ui.display_message(:select_player_mark)
    mark_2 = get_player_mark
    create_player(type_1, mark_1)
    create_player(type_2, mark_2)
    state = @game.prepare_display_state
    @ui.display_board(state)
    play_game
    end_game
    start_the_game unless !play_again?
  end
  
  def play_game
    while !@game.is_over?
      player_1_move = get_move(1)
      state = @game.make_move_player(1, player_1_move)
      @ui.display_board(state)
      break if @game.is_over?
      player_2_move = get_move(2)
      state = @game.make_move_player(2, player_2_move)
      @ui.display_board(state)
    end
  end

  def end_game
    result = @game.result
    @ui.display_message(result)
  end
  
  def create_game
    @game = Game.new
  end
  
  def get_player_type
    type = @ui.read_input
    while !@validate.player_input(type)
      @ui.display_message(:invalid_selection, :determine_player_type)
      type = @ui.read_input
    end
    type = type.upcase
  end
  
  def get_player_mark
    mark = @ui.read_input
    while !@validate.mark_input(mark)
      @ui.display_message(:invalid_selection, :select_player_mark)
      mark = @ui.read_input
    end
    mark = mark.upcase
  end
  
  def create_player(type, mark)
    @game.create_human_player(mark) if type == "H"
    @game.create_computer_player(mark) if type == "C"
  end
  
  def get_human_move
    @ui.display_message(:select_square)
    cell_number = @ui.read_input
    while !@validate.number_input(cell_number) || @game.square_taken?(cell_number) == true
      @ui.display_message(:invalid_selection, :select_square)
      cell_number = @ui.read_input
    end
    cell_number = cell_number.to_i - 1
  end
  
  def get_move(player)
    move = @game.get_player_move(player)
    if move == false
      move = get_human_move
    end
    move
  end
  
  def play_again?
    @ui.display_message(:play_again?)
    choice = @ui.read_input
    while !@validate.play_again_input(choice)
      @ui.display_message(:invalid_selection, :play_again?)
      choice = @ui.read_input
    end
    choice = choice.upcase
    return false if choice == "N"
    return true if choice == "Y"
  end
end
